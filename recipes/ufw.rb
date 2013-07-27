package "ufw"

rules = ["ufw --force enable"]
rules += node[:firewall]
rules << "ufw reload"

execute "Setting up UFW" do
  command rules.join("\n")
end
