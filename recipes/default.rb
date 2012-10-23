case node[:platform]
when "debian", "ubuntu"
  include_recipe "apt"
end

node[:bootstrap][:packages][:remove].each do |name|
  package name do
    action :remove
  end
end

wan_up = `host -W 1 google.com`.index(/has address/)

if wan_up
  # install new packages
  node[:bootstrap][:packages][:install].each do |name|
    package name do
      only_if "[ $(apt-cache show #{name} | grep -c #{name}) -gt 0 ]"
    end
  end

  # configure vnstat
  if node[:bootstrap][:packages][:install].include?("vnstat")
    execute "Ensure vnstat has a database for eth0" do
      command "vnstat -u -i eth0"
      not_if "[ -f /var/lib/vnstat/eth0 ]"
    end

    service "vnstat" do
      action [:enable, :start]
    end
  end

  # enable sysstat logging
  if node[:bootstrap][:packages][:install].include?("sysstat")
    bash "Ensure sar logging is enabled" do
      code %{
        if [ $(grep -c 'ENABLED="true"' /etc/default/sysstat) = 0 ]
        then
          sed -i 's/ENABLED="false"/ENABLED="true"/g' /etc/default/sysstat
        fi
        exit 0
      }
    end
  end
end

# memory stats helper
cookbook_file "/usr/local/bin/memory_stats" do
  source "memory_stats"
  mode 0755
end

include_recipe "bootstrap::hostname" if node.has_key?(:host)
