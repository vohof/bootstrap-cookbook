action :create do

  # You can just put in there, for other files to be created though
  directory @@user.home do
    recursive true
  end

  user @@user.name do
    supports :manage_home => true
    home @@user.home
    shell @@user.shell
    password  @@user.password
  end

  # You can't create a folder owned by a specific user before that user even
  # exists !! ^^^ check line 3
  directory @@user.home do
    owner @@user.home_owner
    group @@user.home_group
    mode new_resource.home_permission
  end

  ssh_authorized_keys @@user.name do
    ssh_keys new_resource.ssh_keys
    home @@user.home
  end

  cookbook_file "#{@@user.home}/.ssh/config" do
    cookbook "bootstrap"
    source "ssh_config"
    owner @@user.name
    group @@user.name
    mode "0644"
    backup false
    action :create_if_missing
  end

  bootstrap_user_groups @@user.name do
    groups new_resource.groups
    allows new_resource.allows
  end

  if new_resource.groups.include?("rvm")
    file "#{@@user.home}/.gemrc" do
      owner @@user.name
      group @@user.name
      content "gem: --no-user-install --no-ri --no-rdoc"
      mode "0644"
    end

    template "#{@@user.home}/.rvmrc" do
      cookbook "rvm"
      source "rvmrc.erb"
      owner @@user.name
      group @@user.name
      mode "0644"
      backup false
    end

    bootstrap_profile "rvm" do
      user @@user
      params([
        "[ -f #{node.rvm_script} ] && . '#{node.rvm_script}'",
        "export RAILS_ENV=production",
        "export RACK_ENV=production",
        "export APP_ENV=production"
      ])
    end
  end

  if @@user.shell.include?("bash")
    cookbook_file "#{@@user.home}/.bashrc" do
      cookbook "bootstrap"
      source "bashrc"
      owner @@user.name
      group @@user.name
      mode "0644"
      backup false
      action :create_if_missing
    end

    cookbook_file "#{@@user.home}/.bash_aliases" do
      cookbook "bootstrap"
      source "bash_aliases"
      owner @@user.name
      group @@user.name
      mode "0644"
      backup false
      action :create_if_missing
    end

    cookbook_file "#{@@user.home}/.profile" do
      cookbook "bootstrap"
      source "profile"
      owner @@user.name
      group @@user.name
      mode "0644"
      backup false
    end
  end

end

action :disable do

end

action :delete do

end

def load_current_resource
  @@user = Bootstrap::User.new(new_resource, node)
end
