define :logrotate, :enable => true, :owner => "root", :group => "root", :period => "weekly", :keep => 4 do
  if params[:enable]
    template "/etc/logrotate.d/#{params[:name]}" do
      cookbook "bootstrap"
      source "logrotate.erb"
      owner params[:owner]
      group params[:group]
      mode "0644"
      variables(
        :paths  => params[:paths],
        :period => params[:period],
        :keep   => params[:keep]
      )
    end
  else
    execute "rm /etc/logrotate.d/#{params[:name]}"
  end
end
