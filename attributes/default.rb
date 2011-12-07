default[:bootstrap][:packages][:networking] = %w[
  curl
  iftop
  ethtool
  vnstat
  traceroute
  whois
  bind9-host]

default[:bootstrap][:packages][:utilities] = %w[
  lynx
  logrotate
  lm-sensors
  hddtemp
  pwgen
  gawk
  patch
  ntp
  ntpdate]

default[:bootstrap][:packages][:unarchiving] = %w[
  bzip2
  zip
  unzip
  unrar]

default[:bootstrap][:packages][:essentials] = %w[
  vim
  ack-grep
  screen
  tmux
  tree
  file]

default[:bootstrap][:packages][:sysadmin] = %w[
  htop
  lsof
  strace
  sysstat
  dstat]

default[:remove_packages] = []
