define :add_to_groups, :groups => [] do
  username = params[:name]

  params[:groups].each do |group_name|
    group group_name

    bash "Adding #{username} to #{group_name} group" do
      code "usermod -a -G #{group_name} #{username}"
      only_if %{
        [ $(id #{username} 2>&1 | grep -c uid) -gt 0 ] && \
        [ $(id #{username} | grep -c #{group_name}) -eq 0 ]
      }
    end
  end
end
