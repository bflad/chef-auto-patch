# Cookbook Name:: auto-patch
# Recipe:: default
#
# Copyright 2012
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

include_recipe "cron"

package "yum-plugin-downloadonly" if node["platform_family"] = "rhel"

if node["auto-patch"]["prep"]["weekly"]
  node["auto-patch"]["prep"]["weekday"] = AutoPatch.weekday(node["auto-patch"]["prep"]["weekly"])
  node["auto-patch"]["prep"]["day"] = "*"
elsif node["auto-patch"]["prep"]["monthly"]
  node["auto-patch"]["prep"]["weekday"] = "*"
  node["auto-patch"]["prep"]["day"] = AutoPatch.day(node["auto-patch"]["prep"]["monthly"])
else
  Chef::Application.fatal!("Missing auto-patch-prep monthly or weekly specification.")
end

template "/usr/local/sbin/auto-patch-prep" do
  source "auto-patch-prep.sh.erb"
  owner "root"
  group "root"
  mode "0700"
end

cron_d "auto-patch-prep" do
  hour node["auto-patch"]["prep"]["hour"]
  minute node["auto-patch"]["prep"]["minute"]
  weekday node["auto-patch"]["prep"]["weekday"]
  day node["auto-patch"]["prep"]["day"]
  command "/usr/local/sbin/auto-patch-prep"
  action :delete if node["auto-patch"]["disable"]
end

if node["auto-patch"]["weekly"]
  node["auto-patch"]["weekday"] = AutoPatch.weekday(node["auto-patch"]["weekly"])
  node["auto-patch"]["day"] = "*"
elsif node["auto-patch"]["monthly"]
  node["auto-patch"]["weekday"] = "*"
  node["auto-patch"]["day"] = AutoPatch.day(node["auto-patch"]["monthly"])
else
  Chef::Application.fatal!("Missing auto-patch monthly or weekly specification.")
end

template "/usr/local/sbin/auto-patch" do
  source "auto-patch.sh.erb"
  owner "root"
  group "root"
  mode "0700"
end

cron_d "auto-patch" do
  hour node["auto-patch"]["hour"]
  minute node["auto-patch"]["minute"]
  weekday node["auto-patch"]["weekday"]
  day node["auto-patch"]["day"]
  command "/usr/local/sbin/auto-patch"
  action :delete if node["auto-patch"]["prep"]["disable"]
end
