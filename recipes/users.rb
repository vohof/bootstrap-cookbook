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

node[:bootstrap][:users].each do |username, keys|
  admin_group << username

  user username do
    supports  :manage_home => true
    home      "/home/#{username}"
    shell     '/bin/bash'
  end

  screen_config "/home/#{username}/.screenrc" do
    owner username
    group username
  end

  bash_aliases "/home/#{username}/.bash_aliases" do
    owner username
    group username
  end

  authorized_keys username do
    ssh_keys keys
  end
end

group 'admin' do
  members admin_group
end
