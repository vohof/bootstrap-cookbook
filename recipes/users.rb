node[:system_users].each do |username, properties|
  bootstrap_system_user username do
    password          properties[:password]
    groups            properties[:groups]
    allows            properties[:allows]
    home_basepath     properties[:home_basepath]
    home_permission   properties[:home_permission]
    home_group        properties[:home_group]
    shell             properties[:shell]
    ssh_keys          properties[:keys]
    action            properties[:status]
  end
end
