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

node[:ruby_apps].each do |app_name|
  user app_name do
    supports  :manage_home => true
    home      "/home/#{app_name}"
    shell     '/bin/bash'
  end

  add_to_groups app_name do
    groups %w(rvm deploy)
  end

  cookbook_file "/home/#{app_name}/.gemrc" do
    cookbook "bootstrap"
    source "gemrc"
    owner  app_name
    group  app_name
    mode   "0644"
  end

  # Rails & Rack related
  #
  add_to_profile app_name do
    match "RAILS_ENV"
    string "export RAILS_ENV=production"
  end

  add_to_profile app_name do
    match "RACK_ENV"
    string "export RACK_ENV=production"
  end

  add_to_profile app_name do
    match "APP_ENV"
    string "export APP_ENV=production"
  end

  # RVM related
  #
  add_to_profile app_name do
    match "rvm"
    string "source '#{node[:rvm_script]}'"
  end

  rvmrc_file app_name

  # All users that are allowed to deploy on this hostname
  #
  app_keys = node[:bootstrap][:users].inject([]) { |result, (user, properties)|
    next result if properties[:allow] && !properties[:allow].include?(node.hostname)
    next result unless properties[:deploy]
    result << properties[:keys]
    result
  }.flatten

  authorized_keys app_name do
    ssh_keys app_keys
  end

  # Add logrotation for this ruby app
  # test manually: logrotate -vf /etc/logrotate.d/[app_name]
  logrotate app_name do
    paths "/var/log/#{app_name}/*.log"
    period "daily"
    keep 7
  end
end
