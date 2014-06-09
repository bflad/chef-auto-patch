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

include_recipe 'cron'

unless node['auto-patch']['prep']['disable']
  if node['platform_family'] == 'rhel'
    if node['platform_version'].to_f >= 6.0
      package 'yum-plugin-downloadonly'
    else
      package 'yum-downloadonly'
    end
  end

  if node['auto-patch']['prep']['weekly']
    node.set['auto-patch']['prep']['day'] = '*'
    node.set['auto-patch']['prep']['month'] = '*'
    node.set['auto-patch']['prep']['weekday'] = AutoPatch.weekday(node['auto-patch']['prep']['weekly'])
    Chef::Log.info("Auto patch prep scheduled weekly on #{node['auto-patch']['weekly']} at #{node['auto-patch']['prep']['hour']}:#{node['auto-patch']['prep']['minute']}")
  elsif node['auto-patch']['prep']['monthly']
    next_date = AutoPatch.next_monthly_date(
      node['auto-patch']['prep']['monthly'],
      node['auto-patch']['prep']['hour'],
      node['auto-patch']['prep']['minute'])
    node.set['auto-patch']['prep']['day'] = next_date.day
    node.set['auto-patch']['prep']['month'] = next_date.month
    node.set['auto-patch']['prep']['weekday'] = '*'
    Chef::Log.info("Auto patch prep scheduled for #{next_date.strftime('%Y-%m-%d')} at #{node['auto-patch']['prep']['hour']}:#{node['auto-patch']['prep']['minute']}")
  else
    Chef::Application.fatal!('Missing auto-patch prep monthly or weekly specification.')
  end
end

template '/usr/local/sbin/auto-patch-prep' do
  source 'auto-patch-prep.sh.erb'
  owner 'root'
  group 'root'
  mode '0700'
  action :delete if node['auto-patch']['prep']['disable']
end

cron_d 'auto-patch-prep' do
  hour node['auto-patch']['prep']['hour']
  minute node['auto-patch']['prep']['minute']
  weekday node['auto-patch']['prep']['weekday']
  day node['auto-patch']['prep']['day']
  month node['auto-patch']['prep']['month']
  command '/usr/local/sbin/auto-patch-prep'
  action :delete if node['auto-patch']['prep']['disable']
end

unless node['auto-patch']['disable']
  if node['auto-patch']['weekly']
    node.set['auto-patch']['day'] = '*'
    node.set['auto-patch']['month'] = '*'
    node.set['auto-patch']['weekday'] = AutoPatch.weekday(node['auto-patch']['weekly'])
    Chef::Log.info("Auto patch scheduled weekly on #{node['auto-patch']['weekly']} at #{node['auto-patch']['hour']}:#{node['auto-patch']['minute']}")
  elsif node['auto-patch']['monthly']
    next_date = AutoPatch.next_monthly_date(
      node['auto-patch']['monthly'],
      node['auto-patch']['hour'],
      node['auto-patch']['minute'])
    node.set['auto-patch']['day'] = next_date.day
    node.set['auto-patch']['month'] = next_date.month
    node.set['auto-patch']['weekday'] = '*'
    Chef::Log.info("Auto patch scheduled for #{next_date.strftime('%Y-%m-%d')} at #{node['auto-patch']['hour']}:#{node['auto-patch']['minute']}")
  else
    Chef::Application.fatal!('Missing auto-patch monthly or weekly specification.')
  end
end

template '/usr/local/sbin/auto-patch' do
  source 'auto-patch.sh.erb'
  owner 'root'
  group 'root'
  mode '0700'
  action :delete if node['auto-patch']['disable']
end

cron_d 'auto-patch' do
  hour node['auto-patch']['hour']
  minute node['auto-patch']['minute']
  weekday node['auto-patch']['weekday']
  day node['auto-patch']['day']
  month node['auto-patch']['month']
  command '/usr/local/sbin/auto-patch'
  action :delete if node['auto-patch']['disable']
end
