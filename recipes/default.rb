case node[:platform]
when "debian", "ubuntu"
  include_recipe "apt"
end
include_recipe "helper"

class Chef::Resource
  include FileHelpers
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
package "unrar"

package "lynx"
package "tmux"

# configure vnstat
Chef::Log.info "Ensure vnstat has a database for eth0"
execute "vnstat -u -i eth0"

# enable sysstat logging
Chef::Log.info "Ensure sar logging is enabled"
sysstat = Chef::Util::FileEdit.new("/etc/default/sysstat")
sysstat.search_file_replace_line('ENABLED="false"', 'ENABLED="true"')
sysstat.write_file

# memory stats helper
cookbook_file "/usr/local/bin/memory_stats" do
  source "memory_stats"
  mode 0755
end

# root config for screen
screen_config "/root/.screenrc"

# root ssh agent for screen and other useful aliases
bash_aliases "/root/.bash_aliases"

# ssh keys
directory "/root/.ssh" do
  mode "0700"
end

file "/root/.ssh/authorized_keys" do
  mode "0600"
  action :create_if_missing
  backup false
end

if node[:bootstrap].has_key? :ssh_keys
  ruby_block "Add my own SSH keys" do
    block do
      ssh_keys = node[:bootstrap][:ssh_keys].join("\n")
      file_write("/root/.ssh/authorized_keys", ssh_keys)
    end
  end
end

ruby_block "Make SSH more secure" do
  block do
    file_replace("/etc/ssh/sshd_config", /^.*Port\s\d+/, "Port #{node[:bootstrap][:sshd][:port]}")
    file_replace("/etc/ssh/sshd_config", /^.*PasswordAuthentication\s\w+/, "PasswordAuthentication #{node[:bootstrap][:sshd][:password_authentication]}")
    file_replace("/etc/ssh/sshd_config", /^.*PermitRootLogin\s\w+/, "PermitRootLogin #{node[:bootstrap][:sshd][:permit_root_login]}")
  end
end

# we'll be using rake to cook the various roles
gem_package "rake"
