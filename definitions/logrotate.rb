define :logrotate,
  :enable => true,
  :owner => "root",
  :group => "root",
  :period => "weekly",
  :keep => 4 do
    app_name = params[:name]
    logrotate_file = "/etc/logrotate.d/#{app_name}"

    if params[:enable]
      paths = params[:paths] || "/var/log/#{app_name}/*.log"

      template logrotate_file do
        cookbook "bootstrap"
        source "logrotate.erb"
        owner params[:owner]
        group params[:group]
        mode "0644"
        variables(
          :paths  => paths,
          :period => params[:period],
          :keep   => params[:keep]
        )
      end
    else
      execute "rm #{logrotate_file}"
    end
end
