module Bootstrap
  class User

    def initialize(username)
      @username = username
    end

    def home
      @home ||= `cat /etc/passwd | awk -F: '/#{@username}/ {print $6}'`.chomp
    end

    def profile
      @profile ||= home << "/.profile"
    end
  end
end
