#
# Cookbook Name:: bootstrap
# Recipe:: users
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

include_recipe "ssh"

admin_group = `grep vagrant /etc/passwd`.empty? ? [] : ['vagrant']
deploy_group = []

node[:system_users].each do |username, properties|
  if properties[:allow]
    next unless properties[:allow].include? node.hostname
  end
  admin_group << username if properties[:admin]
  deploy_group << username if properties[:deploy]

  user username do
    supports  :manage_home => true
    home      "/home/#{username}"
    shell     '/bin/bash'
  end

  bash_aliases "/home/#{username}/.bash_aliases" do
    owner username
    group username
  end

  authorized_keys username do
    ssh_keys properties[:keys]
  end
end

group 'admin' do
  members admin_group
end

group 'deploy' do
  members deploy_group
end
