bash "Setting hostname to #{node[:host]}" do
  code %{
    echo #{node[:host]} > /etc/hostname
    hostname -F /etc/hostname
  }
  only_if "[ $(hostname) != #{node[:host]} ]"
end

bash "#{node[:host]} is localhost" do
  code %{echo "127.0.0.1 #{node[:host]}" >> /etc/hosts}
  only_if "[ $(egrep -c '^127\.0\.0\.1.+#{node[:host]}$' /etc/hosts) -eq 0 ]"
end
