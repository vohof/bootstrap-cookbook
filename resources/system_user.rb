actions :create,
        :disable,
        :delete

attribute :name,              :kind_of => String
attribute :password,          :kind_of => String, :default => ''
attribute :groups,            :kind_of => Array,  :default => []
attribute :home_basepath,     :kind_of => String, :default => '/home'
attribute :home_group,        :kind_of => String
attribute :home_permission,   :kind_of => String, :default => "0750"
attribute :shell,             :kind_of => String, :default => "/bin/bash"
attribute :ssh_keys,          :kind_of => Array,  :default => []
