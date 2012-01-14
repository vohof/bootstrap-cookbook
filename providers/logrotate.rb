action :create do
  template @@logrotate_file do
    cookbook "bootstrap"
    source "logrotate_lwrp.erb"
    owner "root"
    group "root"
    mode "0644"
    variables(
      :logrotate => new_resource,
      :path => @@path
    )
    backup false
 end
end

action :delete do
  execute "rm #{@@logrotate_file}"
end

def load_current_resource
  @@logrotate_file = "/etc/logrotate.d/#{new_resource.service}"
  @@path = new_resource.path || "/var/log/#{new_resource.service}/*.log"
end
