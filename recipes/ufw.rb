execute 'Setting up UFW' do
  command node[:bootstrap][:firewall].join("\n")
end
