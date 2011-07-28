#
# Cookbook Name:: bootstrap
# Recipe:: ruby_apps
#
# Author:: Gerhard Lazu (<gerhard@lazu.co.uk>)
#
# Copyright 2011, Gerhard Lazu
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "rvm"

# Most common Ruby-related dependencies
package "libxml2"
package "libxml2-dev"
package "libxslt1-dev"
package "libcurl3"
package "libcurl3-gnutls"
package "libcurl4-openssl-dev"
package "libreadline5-dev"
package "libssl-dev"
package "libsqlite3-dev"
package "sqlite3"


node[:bootstrap][:ruby_apps].each do |name|
  ruby_app name
	logrotate name
end
