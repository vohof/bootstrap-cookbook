node[:apps].each do |app|
  users_with_deploy_privileges = node[:system_users].inject([]) { |result, (user, user_properties)|
    if user_properties.fetch(:groups) { [] }.include?("deploy")
      result << user_properties[:ssh_keys]
    end
    result
  }.flatten

  bootstrap_system_user app[:name] do
    groups            %w[deploy] + app.fetch(:groups, [])
    allows            app[:allows]
    home_basepath     app[:home_basepath]
    home_permission   app[:home_permission]
    home_group        app[:home_group]
    shell             app[:shell]
    ssh_keys          users_with_deploy_privileges + app.fetch(:authorized_keys, [])
    profile           app[:profile]
    password          app[:password]
    action            app[:status]
  end

  if node.include?(:rbenv) && app.fetch(:groups) { [] }.include?("rbenv")
    rbenv_user app[:name] do
      home_basepath app[:home_basepath]
    end
  end

  unless app[:status] == :delete
    directory "/var/log/#{app[:name]}" do
      owner app[:name]
      mode "0755"
    end

    # test manually: logrotate -vf /etc/logrotate.d/[app_name]
    logrotate app[:name] do
      paths "/var/log/#{app[:name]}/*.log"
      period (app[:logrotate_period] || "daily")
      keep (app[:logrotate_keep] || 7)
    end
  end
end
