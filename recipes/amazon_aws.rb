if File.exists?("/home/ubuntu")
  admin_keys = node[:system_users].inject([]) { |result, (user, user_properties)|
    if user_properties[:groups].include?("admin")
      result << user_properties[:keys]
    end
    result
  }.flatten

  ssh_authorized_keys "ubuntu" do
    ssh_keys admin_keys
    home "/home/ubuntu"
  end
end

directory "/mnt" do
  owner "root"
  group "root"
  mode "0755"
end

package "s3cmd"
