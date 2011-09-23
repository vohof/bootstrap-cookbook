#
# Cookbook Name:: bootstrap
# Recipe:: default
#
# Author:: Gerhard Lazu (<gerhard@lazu.co.uk>)
#
# Copyright 2011, Gerhard Lazu
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
package "pwgen"

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

bash_aliases "/root/.bash_aliases"

gem_package "net-ssh"
gem_package "rake"
gem_package "bundler"
