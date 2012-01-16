include_recipe "rvm"

node[:ruby_apps].each do |app_name, app_properties|
  # All users that are allowed to deploy
  #
  app_keys = node[:system_users].inject([]) { |result, (user, user_properties)|
    if user_properties[:groups].include?("deploy")
      result << user_properties[:keys]
    end
    result
  }.flatten

  bootstrap_system_user app_name do
    name app_name
    groups %w[rvm deploy]
    ssh_keys app_keys
  end

  if app_properties[:domain]
    web_app app_properties[:domain] do
      template      "app.conf.erb"
      cookbook      "apache2"
      user          app_name
      port          app_properties[:port]
      aliases       app_properties[:aliases]
      rewrites      app_properties[:rewrites]
      noncanonical  app_properties[:noncanonical]
      path          app_properties[:path]
    end
  end

  # Add logrotation for this ruby app
  # test manually: logrotate -vf /etc/logrotate.d/[app_name]
  logrotate app_name do
    paths "/var/log/#{app_name}/*.log"
    period "daily"
    keep 7
  end
end
