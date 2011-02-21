include_recipe "rvm"

%w(sqlite3 libsqlite3-dev libxml2 libxml2-dev libxslt1-dev libcurl3 libcurl3-gnutls libcurl4-openssl-dev libreadline5-dev libssl-dev rake).each do |pkg|
  package pkg
end

node[:bootstrap][:ruby_apps].each do |name|
  ruby_app name
	logrotate name
end
