bash "Setting hostname to #{node.fqdn}" do
  code %{
    if [ $HOSTNAME != #{node.fqdn} ]; then
      echo #{node.fqdn} > /etc/hostname
      hostname -F /etc/hostname
    fi
  }
end

host "Assigning #{node.fqdn} as the hostname" do
  search eval("/^#{node.ipaddress}/")
  replace "#{node.ipaddress}\t#{node.fqdn}"
end
