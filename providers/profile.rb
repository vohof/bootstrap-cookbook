action :add do
    bash "Adding to #{new_resource.username}'s profile" do
      code %{
        if [[ $(cat #{@@user.profile}) =~ "#{new_resource.match}" ]]; then
          sed -i "s/#{new_resource.match}.*/#{new_resource.string}/g" #{@@user.profile}
        else
          echo "#{new_resource.string}" >> #{@@user.profile}
        fi
      }
      only_if %{[ $(grep -c "#{new_resource.string}" #{@@user.profile}) = 0 ]}
    end
end

action :remove do
  bash "Removing from #{new_resource.username}'s profile" do
    code %{
      sed -i '/#{new_resource.match}.*/ d' #{@@user.profile}
    }
    only_if %{[ $(grep -c "#{new_resource.string}" #{@@user.profile}) != 0 ]}
  end
end

def load_current_resource
  @@user = Bootstrap::User.new(new_resource.username)
end
