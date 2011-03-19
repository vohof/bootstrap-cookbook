hostname node[:hostname]

host "Assigning #{node[:hostname]} as the hostname" do
  search eval("/^#{node[:ipaddress]}/")
  replace "#{node[:ipaddress]}\t#{node[:hostname]}"
end
