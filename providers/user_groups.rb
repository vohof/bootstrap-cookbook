def add_user_to_group(user, group_name)
  # Creates group if it does not exist
  #
  group group_name

  bash "Adding #{user} to #{group_name} group" do
    code "usermod -a -G #{group_name} #{user}"
    only_if %{
      [ $(id #{user} 2>&1 | grep -c uid) -gt 0 ] && \
      [ $(id #{user} | grep -c "#{group_name})") -eq 0 ]
    }
  end
end

action :add do
  # makes the current user part of another group
  #
  new_resource.groups.each do |group_name|
    add_user_to_group(new_resource.username, group_name)
  end

  # makes another user part of the current user's group
  #
  new_resource.allows.each do |user|
    add_user_to_group(user, new_resource.username)
  end
end
