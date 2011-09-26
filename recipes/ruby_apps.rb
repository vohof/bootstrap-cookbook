include_recipe "rvm"

node[:ruby_apps].each do |app_name|
  user app_name do
    supports  :manage_home => true
    home      "/home/#{app_name}"
    shell     '/bin/bash'
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

  # All users that are allowed to deploy on this hostname
  #
  app_keys = node[:bootstrap][:users].inject([]) { |result, (user, properties)|
    next result if properties[:allow] && !properties[:allow].include?(node.hostname)
    next result unless properties[:deploy]
    result << properties[:keys]
    result
  }.flatten

  authorized_keys app_name do
    ssh_keys app_keys
  end

  logrotate app_name
end
