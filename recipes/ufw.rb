execute 'Setting up UFW' do
  command node[:firewall].join("\n")
end
