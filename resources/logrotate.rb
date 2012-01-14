actions :create, :delete

attribute :service,  :kind_of => String,  :name_attribute => true
attribute :path,     :kind_of => String
attribute :rotate,   :kind_of => String,  :default => "daily",     :equal_to => %w[daily weekly monthly]
attribute :keep,     :kind_of => Fixnum,  :default => 7
attribute :size,     :kind_of => String

def initialize(*args)
  super
  @action = :create
end
