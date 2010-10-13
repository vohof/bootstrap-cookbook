case node[:platform]
when "debian", "ubuntu"
  include_recipe "apt"
end
include_recipe "helper"

class Chef::Resource
  include FileHelpers
end

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
package "logrotate"
package "sysstat"
package "dstat"

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

# ssh keys
directory "/root/.ssh" do
  mode "0700"
end

file "/root/.ssh/authorized_keys" do
  mode "0600"
  action :create_if_missing
  backup false
end

ruby_block "Add my own SSH keys" do
  block do
    data_bag("keys").each do |key|
      properties = data_bag_item("keys", key)
      properties["public"].each do |public_key|
        file_append("/root/.ssh/authorized_keys", public_key)
      end
    end
  end
end
