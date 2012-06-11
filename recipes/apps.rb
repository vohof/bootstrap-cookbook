node[:apps].each do |app|
  next unless app[:active]

  users_with_deploy_privileges = node[:system_users].inject([]) { |result, (user, user_properties)|
    if user_properties[:groups].include?("deploy")
      result << user_properties[:keys]
    end
    result
  }.flatten

  bootstrap_system_user app[:name] do
    name app[:name]
    groups (%w[deploy] + app[:groups])
    ssh_keys users_with_deploy_privileges
    profile app[:profile]
  end

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
