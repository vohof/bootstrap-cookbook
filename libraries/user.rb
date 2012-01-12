module Bootstrap
  class User

    attr_reader :resource, :node, :name

    def initialize(resource, node)
      @resource, @node = resource, node

      @name = resource.username
    end

    def home
      @home ||= (@name == "root") ? "/#{@name}" : "#{resource.home_basepath}/#{@name}"
    end

    def shell
      resource.shell
    end

    def password
      @password ||= resource.password.empty? ? '' : %x{openssl passwd -1 '#{resource.password}'}.chomp
    end

    def profile
      @profile ||= home << "/.profile"
    end

    def home_owner
      resource.groups.include?("sftp") ? "root" : @name
    end

    def home_group
      resource.groups.include?("sftp") ? "root" : (resource.home_group || @name)
    end

    def exists?
      `id #{@name} 2>&1`.index('uid')
    end
  end
end
