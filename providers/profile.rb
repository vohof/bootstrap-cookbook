action :create do
  template "#{@@user.home}/.profile.d/#{new_resource.filename}" do
    cookbook "bootstrap"
    source "profile.d.erb"
    variables(
      :params => new_resource.params
    )
    owner @@user.name
    group @@user.name
    mode "0755"
    backup false
  end
end

action :delete do
  bash "Removing #{@@user.home}/.profile.d/#{new_resource.filename}" do
    code %{
      if [ -e #{@@user.home}/.profile.d/#{new_resource.filename} ]; then
        rm #{@@user.home}/.profile.d/#{new_resource.filename}
      fi
    }
  end
end

def load_current_resource
  @@user = new_resource.user || Bootstrap::User.new(new_resource, node)

  directory "#{@@user.home}/.profile.d" do
    owner @@user.name
    group @@user.name
    mode "0755"
  end
end
