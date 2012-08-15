node[:system_users].each do |username, properties|
  bootstrap_system_user username do
    action            properties[:action]
    allows            properties[:allows]
    git               properties[:git]
    groups            properties[:groups]
    home_basepath     properties[:home_basepath]
    home_group        properties[:home_group]
    home_permission   properties[:home_permission]
    known_hosts       properties[:known_hosts]
    password          properties[:password]
    profile           properties[:profile]
    shell             properties[:shell]
    ssh_keys          properties[:keys]
    ssh_private_key   properties[:ssh_private_key]
    ssh_public_key    properties[:ssh_public_key]
  end
end
