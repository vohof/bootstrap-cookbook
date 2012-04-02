module Bootstrap
  module Passwd
    def htdigest
      return @htdigest if @htdigest

      @htdigest = ["#{new_resource.username}:#{new_resource.realm}:"]
      @htdigest << `echo -n "#{@htdigest.first}#{new_resource.password}" | md5sum | awk {'print $1'}`.chomp
    end

    def htpasswd(passwd_file)
      options = "b"
      options << "c" unless File.exist?(passwd_file)

      `htpasswd -#{options} #{passwd_file} #{new_resource.username} #{new_resource.password}`
    end
  end
end
