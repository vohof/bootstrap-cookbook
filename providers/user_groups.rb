action :add do
  new_resource.groups.each do |group_name|
    group group_name

    bash "Adding #{new_resource.username} to #{group_name} group" do
      code "usermod -a -G #{group_name} #{new_resource.username}"
      only_if %{
        [ $(id #{new_resource.username} 2>&1 | grep -c uid) -gt 0 ] && \
        [ $(id #{new_resource.username} | grep -c #{group_name}) -eq 0 ]
      }
    end
  end
end
