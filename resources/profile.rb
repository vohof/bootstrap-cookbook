actions :create, :delete

attribute :filename,       :kind_of => String,  :name_attribute => true
attribute :params,         :kind_of => Array,   :required => true

attribute :username,       :kind_of => String
attribute :home_basepath,  :kind_of => String,  :default => '/home'
attribute :user,           :kind_of => Object

def initialize(*args)
  super
  @action = :create
end
