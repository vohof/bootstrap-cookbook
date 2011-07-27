#
# Cookbook Name:: bootstrap
# Recipe:: amazon_aws
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

if File.exists? "/home/ubuntu"
  screen_config "/home/ubuntu/.screenrc" do
    owner "ubuntu"
    group "ubuntu"
  end
end

directory "/mnt" do
  owner "root"
  group "root"
  mode "0755"
end

execute "move logging to /mnt/log" do
  command %{
    mv /var/log /mnt/log
    ln -nfs /mnt/log /var/log
  }
  not_if "[ -d /mnt/log ]"
end
