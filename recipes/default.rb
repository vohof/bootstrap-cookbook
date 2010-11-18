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

package "bind9-host"
package "ntp"
package "ntpdate"

package "bzip2"
package "zip"
package "unzip"
package "unrar"

package "lynx"

# memory stats helper
cookbook_file "/usr/local/bin/memory_stats" do
  source "memory_stats"
  mode 0755
end

# root config for screen
screen_config "/root/.screenrc"

# root ssh agent for screen
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

if node.has_key? :ssh_keys
  ruby_block "Add my own SSH keys" do
    block do
      file_write("/root/.ssh/authorized_keys", node[:ssh_keys].join("\n"))
    end
  end
end