hostname node[:hostname]

host "Assigning our own FQDN" do
  search eval("/^#{node[:ipaddress]}/")
  replace "#{node[:ipaddress]}\t#{node[:hostname]}"
end
