bash 'Setting up UFW' do
  code node[:bootstrap][:firewall].join("\n")
end
