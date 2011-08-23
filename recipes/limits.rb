template "/etc/security/limits.conf" do
  cookbook "bootstrap"
  source "limits.conf.erb"
  group "root"
  owner "root"
  mode "0644"
end

ruby_block "Change user limits without restarting" do
  block do
    su_config = Chef::Util::FileEdit.new('/etc/pam.d/su')
    su_config.search_file_replace(
      /^#\s+(session\s+required\s+pam_limits\.so)/,
      "session\trequired\tpam_limits.so"
    )
    su_config.write_file
  end
end
