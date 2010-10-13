# Default stuff to remove/set on servers

package "bind9" do
  action :remove
end

hostname node.name

host "Assigning our own FQDN" do
  search eval("/^#{node[:ipaddress]}/")
  replace "#{node[:ipaddress]}\t#{node.name}"
end
