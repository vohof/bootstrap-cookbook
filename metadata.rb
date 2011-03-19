maintainer       "Gerhard Lazu"
maintainer_email "gerhard@lazu.co.uk"
license          "Apache 2.0"
description      "Default bootstrap tasks"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.2"

depends "apt"

attribute "bootstrap/sshd/port",
  :display_name => "SSH Port",
  :description => "Port on which SSH daemon is enabled",
  :default => "9876"

attribute "bootstrap/sshd/password_authentication",
  :display_name => "SSH Daemon Password Authentication",
  :description => "Whether clear text passwords are allowed in SSH daemon",
  :default => "no"

attribute "bootstrap/sshd/permit_root_login",
  :display_name => "SSH Daemon Root Login",
  :description => "Whether root can login via SSH",
  :default => "yes"
