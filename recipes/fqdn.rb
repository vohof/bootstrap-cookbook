hostname node[:bootstrap][:hostname]

host "Assigning #{node[:bootstrap][:hostname]} as the hostname" do
  search eval("/^#{node[:ipaddress]}/")
  replace "#{node[:ipaddress]}\t#{node[:bootstrap][:hostname]}"
end
