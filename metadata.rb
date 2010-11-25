maintainer       "Gerhard Lazu"
maintainer_email "gerhard@lazu.co.uk"
license          "Apache 2.0"
description      "Sets Ubuntu servers with my favourite sysadmin tools"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1.1"

depends "apt"

attribute "sysadmin/sshd/port",
  :display_name => "SSH Port",
  :description => "Port on which SSH daemon is enabled",
  :default => "9876"

attribute "sysadmin/sshd/password_authentication",
  :display_name => "SSH Daemon Password Authentication",
  :description => "Whether clear text passwords are allowed in SSH daemon",
  :default => "no"

attribute "sysadmin/sshd/permit_root_login",
  :display_name => "SSH Daemon Root Login",
  :description => "Whether root can login via SSH",
  :default => "yes"