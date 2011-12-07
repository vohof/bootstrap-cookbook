actions :add, :remove

attribute :username,  :kind_of => String,  :name_attribute => true
attribute :string,    :kind_of => String,  :required => true
attribute :match,     :kind_of => String,  :required => true

def initialize(*args)
  super
  @action = :add
end
