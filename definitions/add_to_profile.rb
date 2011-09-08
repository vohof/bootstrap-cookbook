define :add_to_profile, :string => nil, :match => nil do
  username = params[:name]
  profile = "/home/#{username}/.profile"

  if params[:string] && params[:match]
    bash "Add #{params[:string]} to #{username} bash profile" do
      code %{
        if [ -f #{profile} ]; then
          [ $(grep -c #{params[:match]} #{profile}) -eq 0 ] && echo "#{params[:string]}" >> #{profile}
        fi
        exit 0
      }
    end
  end

end
