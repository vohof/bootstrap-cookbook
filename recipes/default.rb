case node[:platform]
when "debian", "ubuntu"
  include_recipe "apt"
end

if Chef::Util.respond_to?(:wan_up?)
  skip = Chef::Util.wan_up? ? false : true
else
  skip = false
end

unless skip
  node.bootstrap.packages.each do |group, packages|
    packages.each do |name|
      package name do
        only_if "[ $(apt-cache show #{name} | grep -c #{name}) -gt 0 ]"
      end
    end
  end

  # configure vnstat
  execute "Ensure vnstat has a database for eth0" do
    command "vnstat -u -i eth0"
    not_if "test -f /var/lib/vnstat/eth0"
  end
  execute "Ensure vnstat daemon is running" do
    command "/etc/init.d/vnstat start"
    not_if "ps aux | grep [v]nstat"
  end

  # enable sysstat logging
  ruby_block "Ensure sar logging is enabled" do
    block do
      sysstat = Chef::Util::FileEdit.new("/etc/default/sysstat")
      sysstat.search_file_replace_line('ENABLED="false"', 'ENABLED="true"')
      sysstat.write_file
    end
  end
end

# memory stats helper
cookbook_file "/usr/local/bin/memory_stats" do
  source "memory_stats"
  mode 0755
end

bash_aliases "/root/.bash_aliases"


include_recipe "bootstrap::hostname" if node.respond_to?(:host)
