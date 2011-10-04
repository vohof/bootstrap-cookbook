case node[:platform]
when "debian", "ubuntu"
  include_recipe "apt"
end

apt_repository "brightbox" do
  uri "http://apt.brightbox.net"
  key "http://apt.brightbox.net/release.asc"
  distribution `lsb_release -cs`.chomp
  components ["passenger-nginx"]
  action :add
end

package "libapache2-mod-passenger"
