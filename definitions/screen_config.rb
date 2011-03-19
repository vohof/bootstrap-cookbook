define :screen_config, :owner => "root", :group => "root" do
  cookbook_file params[:name] do
    cookbook "bootstrap"
    source "screenrc"
    owner params[:owner]
    group params[:group]
    mode "0644"
    backup false
  end
end
