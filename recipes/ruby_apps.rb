include_recipe "rvm"

node[:ruby_apps].each do |app_name, properties|
  user app_name do
    supports  :manage_home => true
    home      "/home/#{app_name}"
    shell     '/bin/bash'
  end

  directory "/home/#{app_name}" do
    owner app_name
    group app_name
    mode 0755
  end

  add_to_groups app_name do
    groups %w(rvm deploy)
  end

  cookbook_file "/home/#{app_name}/.gemrc" do
    cookbook "bootstrap"
    source "gemrc"
    owner  app_name
    group  app_name
    mode   "0644"
  end

  # Rails & Rack related
  #
  add_to_profile app_name do
    match "RAILS_ENV"
    string "export RAILS_ENV=production"
  end

  add_to_profile app_name do
    match "RACK_ENV"
    string "export RACK_ENV=production"
  end

  add_to_profile app_name do
    match "APP_ENV"
    string "export APP_ENV=production"
  end

  # RVM related
  #
  add_to_profile app_name do
    match "rvm"
    string "source '#{node[:rvm_script]}'"
  end

  rvmrc_file app_name

  rvm_profile app_name

  web_app properties[:domain] do
    template      "app.conf.erb"
    cookbook      "hosting"
    user          app_name
    port          properties[:port]
    aliases       properties[:aliases]
    rewrites      properties[:rewrites]
    noncanonical  properties[:noncanonical]
    path          properties[:path]
  end

  # add_to_groups app_name do
  #   groups %w(www-data)
  # end

  # All users that are allowed to deploy
  #
  app_keys = node[:rvm_users].inject([]) { |result, user|
    if user_properties = node[:system_users][user]
      result << user_properties[:keys]
    end
    result
  }.flatten

  authorized_keys app_name do
    ssh_keys app_keys
  end

  logrotate app_name
end
