define :hostname do
  execute "hostname #{params[:name]}"
  # Ensure hostname will be the same after reboot
  unless `cat /etc/hostname`.include? params[:name]
    execute "echo '#{params[:name]}' > /etc/hostname"
  end
end
