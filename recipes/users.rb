include_recipe "ssh"

admin_group = `grep vagrant /etc/passwd`.empty? ? [] : ['vagrant']
deploy_group = []
root_keys = []

node[:system_users].each do |username, properties|
  if properties[:admin]
    admin_group << username
    root_keys << properties[:keys]
  end
  deploy_group << username if properties[:deploy]

  user_home = properties[:home] || "/home/#{username}"

  user_password = properties[:password] ? %x{openssl passwd -1 #{properties[:password]}}.chomp : ''

  user username do
    supports  :manage_home => true
    home      user_home
    shell     "/bin/bash"
    password  user_password
  end

  add_to_groups username do
    groups %w(www-data)
  end

  directory user_home do
    owner username
    group "www-data"
    mode 0750
  end

  bash_aliases "#{user_home}/.bash_aliases" do
    owner username
    group username
  end

  authorized_keys username do
    ssh_keys properties[:keys]
  end
end

# Add all admin users to this group
#
group 'admin' do
  members admin_group
end

# Add all admin user keys to root
#
authorized_keys "root" do
  ssh_keys root_keys
end

# Add all users that can deploy to this group
#
group 'deploy' do
  members deploy_group
end
