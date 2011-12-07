actions :add, :remove

attribute :username,  :kind_of => String, :name_attribute => true
attribute :groups,    :kind_of => Array, :default => []
attribute :allows,    :kind_of => Array, :default => []

def initialize(*args)
  super
  @action = :add
end
