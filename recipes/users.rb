require_recipe "ssh"

# root config for screen
screen_config "/root/.screenrc"

# root ssh agent for screen and other useful aliases
bash_aliases "/root/.bash_aliases"

sysadmin_group = `grep vagrant /etc/passwd`.empty? ? [] : ['vagrant']
node[:bootstrap][:users].each do |username, keys|
  sysadmin_group << username

  user username do
    supports  :manage_home => true
    home      "/home/#{username}"
    shell     '/bin/bash'
  end

  screen_config do
    owner username
    group username
  end

  authorized_keys username do
    ssh_keys keys
  end
end
