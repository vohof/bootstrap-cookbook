action :create do
  user_password = new_resource.password.empty? ? '' : %x{openssl passwd -1 '#{new_resource.password}'}.chomp
  user_home = "#{new_resource.home_basepath}/#{new_resource.name}"

  user new_resource.name do
    supports  :manage_home => true
    home      user_home
    shell     new_resource.shell
    password  user_password
  end

  directory user_home do
    owner new_resource.name
    group new_resource.home_group || new_resource.name
    mode new_resource.home_permission
  end

  cookbook_file new_resource.name do
    cookbook "bootstrap"
    source "bash_aliases"
    owner new_resource.name
    group new_resource.name
    mode "0644"
    backup false
    only_if { new_resource.shell.include?("bash") }
  end

  ssh_authorized_keys new_resource.name do
    ssh_keys new_resource.ssh_keys
  end

  bootstrap_user_groups new_resource.name do
    groups new_resource.groups
  end
end

action :disable do

end

action :delete do

end
