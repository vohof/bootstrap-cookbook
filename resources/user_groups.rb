actions :manage

attribute :username,   :kind_of => String,  :name_attribute => true
attribute :groups,     :kind_of => Array,   :default => []
attribute :notgroups,  :kind_of => Array,   :default => []
attribute :allows,     :kind_of => Array,   :default => []

def initialize(*args)
  super
  @action = :manage
end
