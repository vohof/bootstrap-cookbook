bash "Setting hostname to #{node.host}" do
  code %{
    echo #{node.host} > /etc/hostname
    hostname -F /etc/hostname
  }
  only_if "[ $(hostname) != #{node.host} ]"
end

host "Assigning #{node.host} as the hostname" do
  search eval("/^#{node.ipaddress}/")
  replace "#{node.ipaddress}\t#{node.host}"
end
