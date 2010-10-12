define :host, :search => nil, :replace => nil do
  unless params[:search].nil?
    hosts = Chef::Util::FileEdit.new("/etc/hosts")
    hosts.search_file_replace_line(params[:search], params[:replace])
    hosts.write_file
  end
end