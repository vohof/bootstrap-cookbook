actions :create, :delete
default_action :create

attribute :priority,         :kind_of => Fixnum,  :default => 60
attribute :directives,       :kind_of => Array,   :default => []
