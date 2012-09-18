# http://linuxcommand.org/man_pages/logrotate8.html
actions :create, :delete

attribute :service,       :kind_of => String,  :name_attribute => true
attribute :path,          :kind_of => String
attribute :rotate,        :kind_of => String,  :default => "daily",     :equal_to => %w[daily weekly monthly]
attribute :keep,          :kind_of => Fixnum,  :default => 7
attribute :size,          :kind_of => String
attribute :permissions,   :kind_of => String
attribute :copytruncate,  :kind_of => [TrueClass, FalseClass], :default => true
attribute :compresscmd,   :kind_of => String, :default => "/bin/bzip2"
attribute :uncompresscmd, :kind_of => String, :default => "/bin/bunzip2"
attribute :compressext,   :kind_of => String, :default => ".bz2"
attribute :sharedscripts, :kind_of => [TrueClass, FalseClass], :default => false
attribute :prerotate,     :kind_of => String
attribute :postrotate,    :kind_of => String

def initialize(*args)
  super
  @action = :create
end
