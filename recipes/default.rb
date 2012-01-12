case node[:platform]
when "debian", "ubuntu"
  include_recipe "apt"
end

if Chef::Extensions.wan_up?
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
      not_if "test -f /var/lib/vnstat/eth0"
    end

    service "vnstat" do
      action [:enable, :start]
    end
  end

  # enable sysstat logging
  if node[:bootstrap][:packages][:install].include?("sysstat")
    ruby_block "Ensure sar logging is enabled" do
      block do
        sysstat = Chef::Util::FileEdit.new("/etc/default/sysstat")
        sysstat.search_file_replace_line('ENABLED="false"', 'ENABLED="true"')
        sysstat.write_file
      end
    end
  end
end

# memory stats helper
cookbook_file "/usr/local/bin/memory_stats" do
  source "memory_stats"
  mode 0755
end

bash_aliases "/root/.bash_aliases"

include_recipe "bootstrap::hostname" if node.has_key?(:host)

node[:bootstrap][:packages][:remove].each do |name|
  package name do
    action :remove
  end
end
