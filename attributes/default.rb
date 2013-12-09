# Cookbook Name:: auto-patch
# Attributes:: default
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

default['auto-patch']['disable'] = false
default['auto-patch']['hour'] = 3
default['auto-patch']['minute'] = 0
default['auto-patch']['monthly'] = 'first sunday'
default['auto-patch']['reboot'] = true
default['auto-patch']['splay'] = 0
default['auto-patch']['weekly'] = nil

default['auto-patch']['prep']['clean'] = true
default['auto-patch']['prep']['disable'] = true
default['auto-patch']['prep']['hour'] = 2
default['auto-patch']['prep']['minute'] = 0
default['auto-patch']['prep']['monthly'] = 'first sunday'
default['auto-patch']['prep']['splay'] = 1800
default['auto-patch']['prep']['weekly'] = nil
default['auto-patch']['prep']['update_updater'] = true
