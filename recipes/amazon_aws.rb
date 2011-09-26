if File.exists? "/home/ubuntu"
  node[:bootstrap][:users].each do |user, properties|
    next unless properties[:admin]
    properties[:keys].each do |key|
      bash "adding #{user}'s SSH key to ubuntu user" do
        code %{
          if [ $(grep -c "#{key}" /home/ubuntu/.ssh/authorized_keys) -eq 0 ]; then
            echo "#{key}" >> /home/ubuntu/.ssh/authorized_keys
          fi
          exit 0
        }
      end
    end
  end
end

directory "/mnt" do
  owner "root"
  group "root"
  mode "0755"
end

package "s3cmd"
