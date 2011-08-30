node[:bootstrap][:removed_users].each do |user|
  bash "Deleting #{user} from system" do
    code <<-EOH
      skill -KILL -u #{user}
      userdel #{user}
      [ -d /home/#{user} ] && rm -fR /home/#{user}
    EOH
    only_if "[ $(id #{user} 2>&1 | grep -c uid) -gt 0 ]"
  end
end
