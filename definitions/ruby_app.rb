define :ruby_app do
  username = params[:name]

  user username do
    supports  :manage_home => true
    home      "/home/#{username}"
    shell     '/bin/bash'
  end

  ruby_block 'add_to_group' do
    block do
      %w{www-data rvm}.each do |group|
        unless `id #{username}`.include? group
          system "usermod -a -G #{group} #{username}"
        end
      end
    end
  end

  cookbook_file "/home/#{username}/.gemrc" do
    cookbook "bootstrap"
    source "gemrc"
    owner  username
    group  username
    mode   "0644"
  end

  add_rvmrc_file_to username

  screen_config do
    owner username
    group username
  end

  authorized_keys username do
    ssh_keys node[:bootstrap][:users].values.flatten
  end
end
