execute "Setting hostname to #{node[:fqdn]}" do
  command %{
    hostname #{node[:fqdn]}
    echo #{node[:fqdn]} > /etc/hostname
  }
end

host "Assigning #{node[:fqdn]} as the hostname" do
  search eval("/^#{node[:ipaddress]}/")
  replace "#{node[:ipaddress]}\t#{node[:fqdn]}"
end
