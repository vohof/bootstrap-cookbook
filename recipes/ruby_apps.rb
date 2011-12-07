include_recipe "rvm"

node[:ruby_apps].each do |app_name, properties|
  bootstrap_system_user app_name do
    name app_name
    groups %w[rvm deploy]
  end

  web_app properties[:domain] do
    template      "app.conf.erb"
    cookbook      "apache2"
    user          app_name
    port          properties[:port]
    aliases       properties[:aliases]
    rewrites      properties[:rewrites]
    noncanonical  properties[:noncanonical]
    path          properties[:path]
  end

  # add_to_groups app_name do
  #   groups %w(www-data)
  # end

  # All users that are allowed to deploy
  #
  app_keys = node[:rvm_users].inject([]) { |result, user|
    if user_properties = node[:system_users][user]
      result << user_properties[:keys]
    end
    result
  }.flatten

  authorized_keys app_name do
    ssh_keys app_keys
  end

  # Add logrotation for this ruby app
  # test manually: logrotate -vf /etc/logrotate.d/[app_name]
  logrotate app_name do
    paths "/var/log/#{app_name}/*.log"
    period "daily"
    keep 7
  end
end
