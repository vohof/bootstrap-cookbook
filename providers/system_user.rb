action :ignore do
  # Sometimes it is necessary to prevent any changes to a user
  # For example, when there are multiple provisioners running on the same system
end

action :create do
  # So that other files can be created
  #
  directory @@user.home do
    recursive true
  end

  # Create user so that we can assign ownership of dirs & files
  #
  user @@user.name do
    supports :manage_home => true
    home @@user.home
    shell @@user.shell
    password  @@user.password
  end

  # Now that the user exists, correct ownership of home dir
  #
  directory @@user.home do
    owner @@user.home_owner
    group @@user.home_group
    mode new_resource.home_permission
  end

  ssh_authorized_keys @@user.name do
    ssh_keys new_resource.ssh_keys
    home @@user.home
  end

  file "#{@@user.home}/.ssh/known_hosts" do
    owner @@user.name
    group @@user.name
    mode "0644"
    backup false
    action :create
  end

  new_resource.known_hosts.each do |host|
    ssh_key host do
      local_known_hosts "#{@@user.home}/.ssh/known_hosts"
      action :allow
    end
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

  if new_resource.git
    template "#{@@user.home}/.gitconfig" do
      source "gitconfig.erb"
      mode "0644"
      owner @@user.name
      group @@user.name
      variables({
        :git => new_resource.git
      })
    end
  end

  if new_resource.ssh_private_key && new_resource.ssh_public_key
    ssh_key "localhost" do
      username @@user.name
      home @@user.home
      private_key new_resource.ssh_private_key
      public_key new_resource.ssh_public_key
      action :create
    end
  end

  bootstrap_user_groups @@user.name do
    groups new_resource.groups
    notgroups %w[nologin] + new_resource.notgroups
    allows new_resource.allows
  end

  if new_resource.profile.any?
    bootstrap_profile "default" do
      user @@user
      params new_resource.profile
    end
  end

  if new_resource.groups.include?("nvm")
    bootstrap_profile "nvm" do
      user @@user
      params ["if [ -e #{node[:nvm][:dir]}/nvm.sh ]; then . #{node[:nvm][:dir]}/nvm.sh; fi"]
    end
  end

  if ((%w[ruby rvm rbenv] & new_resource.groups).length > 0)
    file "#{@@user.home}/.gemrc" do
      owner @@user.name
      group @@user.name
      content "gem: --no-user-install --no-ri --no-rdoc"
      mode "0644"
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
    end

    cookbook_file "#{@@user.home}/.bash_aliases" do
      cookbook "bootstrap"
      source "bash_aliases"
      owner @@user.name
      group @@user.name
      mode "0644"
      backup false
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
  bash "Stopping all #{@@user.name} system user processes" do
    code %{
      [[ "$(id #{@@user.name} 2>&1)" =~ "uid" ]] && skill -KILL -u #{@@user.name}
      exit 0
    }
  end

  bash "Locking #{@@user.name} system user" do
    code %{
      if [[ "$(id #{@@user.name} 2>&1)" =~ "uid" ]]
      then
        passwd #{@@user.name} -l
        chown root:root -fR #{@@user.home}/.ssh
        chsh -s /usr/sbin/nologin #{@@user.name}
      fi
    }
  end

  bootstrap_user_groups @@user.name do
    groups %w[nologin]
  end
end

action :delete do
  bash "Stopping all #{@@user.name} system user processes" do
    code %{
      [[ "$(id #{@@user.name} 2>&1)" =~ "uid" ]] && skill -KILL -u #{@@user.name}
      exit 0
    }
  end

  bash "Deleting #{@@user.name} system user" do
    code %{
      test -d #{@@user.home} && rm -fR #{@@user.home}
      test -d /var/log/#{@@user.name} && rm -fR /var/log/#{@@user.name}
      rm -f /etc/init/#{@@user.name}*
      [[ "$(id #{@@user.name} 2>&1)" =~ "uid" ]] && userdel #{@@user.name}
      exit 0
    }
  end
end

def load_current_resource
  require ::File.expand_path('../../lib/user', __FILE__)
  @@user = Bootstrap::User.new(new_resource, node)
end
