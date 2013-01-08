def create_group_if_missing(group_name)
  # Since chef 0.10.10 all users in this group will get discarded every time
  # you run this provider with the default action
  #
  group group_name do
    only_if %{[ $(egrep -ic "^#{group_name}" /etc/group) = 0 ]}
  end
end

def group_management(user_name, group_name, action=:add)
  options = (action == :add) ? "-a" : "-d"

  create_group_if_missing(group_name)

  bash "Adding #{user_name} to #{group_name} group" do
    code "gpasswd #{options} #{user_name} #{group_name}; exit 0"
  end
end

def manage
  # makes another user part of the current user's group
  #
  new_resource.allows.each do |user_name|
    group_management(user_name, new_resource.username)
  end

  # makes the current user part of another group
  #
  new_resource.groups.each do |group_name|
    group_management(new_resource.username, group_name)
  end

  # removes user from groups
  #
  new_resource.notgroups.each do |group_name|
    group_management(new_resource.username, group_name, :remove)
  end
end

action :manage do
  manage
end

# Backwards-compatible
action :add do
  manage
end
