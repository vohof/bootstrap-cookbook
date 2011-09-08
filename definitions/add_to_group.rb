define :add_to_groups, :groups => [] do
  username = params[:name]

  params[:groups].each do |group|
    bash "Adding #{username} to #{group} group" do
      code "usermod -a -G #{group} #{username}"
      only_if %{
        [ $(id #{username} 2>&1 | grep -c uid) -gt 0 ] && \
        [ $(id #{username} | grep -c #{group}) -eq 0 ]
      }
    end
  end
end
