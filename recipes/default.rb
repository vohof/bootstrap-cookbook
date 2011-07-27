case node[:platform]
when "debian", "ubuntu"
  include_recipe "apt"
end

# should make these configurable really...
package "vim"
package "curl"
package "ack-grep"
package "screen"
package "tree"
package "file"
package "gawk"
package "patch"

package "strace"
package "lsof"
package "htop"
package "iftop"
package "ethtool"
package "vnstat"
package "ntop"
package "logrotate"
package "sysstat"
package "dstat"
package "lm-sensors"
package "hddtemp"

package "bind9-host"
package "ntp"
package "ntpdate"

package "bzip2"
package "zip"
package "unzip"
package "unrar" do
  not_if "[ $(apt-cache show unrar | grep -c unrar) -lt 1 ]"
end

package "lynx"
package "tmux"

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

# memory stats helper
cookbook_file "/usr/local/bin/memory_stats" do
  source "memory_stats"
  mode 0755
end
