define :bash_aliases, :owner => "root", :group => "root" do
  cookbook_file params[:name] do
    cookbook "sysadmin"
    source "bash_aliases"
    owner params[:owner]
    group params[:group]
    mode "0644"
    backup false
  end
end
