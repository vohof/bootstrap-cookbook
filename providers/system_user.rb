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
    owner (new_resource.groups.include?("sftp") ? "root" : new_resource.name)
    group (new_resource.groups.include?("sftp") ? "root" : (new_resource.home_group || new_resource.name))
    mode new_resource.home_permission
  end

  if new_resource.shell.include?("bash")
    cookbook_file "#{user_home}/.bashrc" do
      source "bashrc"
      owner  new_resource.name
      group  new_resource.name
      mode   "0644"
      backup false
    end

    cookbook_file "#{user_home}/.bash_aliases" do
      source "bash_aliases"
      owner new_resource.name
      group new_resource.name
      mode "0644"
      backup false
    end

    cookbook_file "#{user_home}/.profile" do
      source "profile"
      owner  new_resource.name
      group  new_resource.name
      mode   "0644"
      backup false
      action :create_if_missing
    end
  end

  ssh_authorized_keys new_resource.name do
    ssh_keys new_resource.ssh_keys
    home user_home
  end

  cookbook_file "#{user_home}/.ssh/config" do
    source "ssh_config"
    owner  new_resource.name
    group  new_resource.name
    mode   "0644"
    backup false
    action :create_if_missing
  end

  bootstrap_user_groups new_resource.name do
    groups new_resource.groups
    allows new_resource.allows
  end

  if new_resource.groups.include?("rvm")
    file "#{user_home}/.gemrc" do
      owner  new_resource.name
      group  new_resource.name
      content "gem: --no-user-install --no-ri --no-rdoc"
      mode   "0644"
    end

    bootstrap_profile new_resource.name do
      match "source '#{node.rvm_script}'"
      string "source '#{node.rvm_script}'"
    end

    template "#{user_home}/.rvmrc" do
      cookbook "rvm"
      source "rvmrc.erb"
      owner new_resource.name
      group new_resource.name
      mode "0644"
      backup false
    end

    bootstrap_profile new_resource.name do
      match "export RAILS_ENV"
      string "export RAILS_ENV=production"
    end

    bootstrap_profile new_resource.name do
      match "export RACK_ENV"
      string "export RACK_ENV=production"
    end

    bootstrap_profile new_resource.name do
      match "export APP_ENV"
      string "export APP_ENV=production"
    end
  end
end

action :disable do

end

action :delete do

end
