include_recipe "ssh"

admin_group = `grep vagrant /etc/passwd`.empty? ? [] : ['vagrant']
deploy_group = []

node[:system_users].each do |username, properties|
  if properties[:allow]
    next unless properties[:allow].include? node.hostname
  end
  admin_group << username if properties[:admin]
  deploy_group << username if properties[:deploy]

  user username do
    supports  :manage_home => true
    home      "/home/#{username}"
    shell     '/bin/bash'
  end

  bash_aliases "/home/#{username}/.bash_aliases" do
    owner username
    group username
  end

  authorized_keys username do
    ssh_keys properties[:keys]
  end
end

group 'admin' do
  members admin_group
end

group 'deploy' do
  members deploy_group
end
