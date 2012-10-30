# chef-auto-patch [![Build Status](https://secure.travis-ci.org/bflad/chef-auto-patch.png?branch=master)](http://travis-ci.org/bflad/chef-auto-patch)

## Description

Chef Cookbook for automatically patching nodes. Handles weekly or monthly
patching routines with or without node splay. Can automatically prepare node for
true patch window by cleaning and pre-downloading packages.

## Requirements

### Platforms

* RedHat 6.3 (Santiago)
* Ubuntu 12.04 (Precise)

### Cookbooks

* cron

## Attributes

* `node["auto-patch"]["disable"]` - defaults to false
* `node["auto-patch"]["hour"]` - defaults to "3"
* `node["auto-patch"]["minute"]` - defaults to "0"
* `node["auto-patch"]["monthly"]` - auto patching occurs once a month on the
  corresponding textual week number ("first","second",etc) and weekday
  ("monday","tuesday",etc), overridden by `node["auto-patch"]["weekly"]`,
  defaults to "first sunday"
* `node["auto-patch"]["reboot"]` - reboot automatically after patching, defaults
  to true
* `node["auto-patch"]["splay"]` - amount of random delay before beginning,
  defaults to "300"
* `node["auto-patch"]["weekly"]` - auto patching occurs once a week on the
  corresponding textual weekday ("monday","tuesday",etc), overrides
  `node["auto-patch"]["monthly"]`, defaults to nil

### Patch Preparation

* `node["auto-patch"]["prep"]["clean"]` - cleans updater cache files, defaults
  to true
* `node["auto-patch"]["prep"]["disable"]` - defaults to false
* `node["auto-patch"]["prep"]["hour"]` - defaults to "2"
* `node["auto-patch"]["prep"]["minute"]` - defaults to "0"
* `node["auto-patch"]["prep"]["monthly"]` - auto patching prep occurs once a
  month on the corresponding textual week number ("first","second",etc) and
  weekday ("monday","tuesday",etc), overridden by
  `node["auto-patch"]["prep"]["weekly"]`, defaults to "first sunday"
* `node["auto-patch"]["prep"]["splay"]` - amount of random delay before
  beginning, defaults to "1800"
* `node["auto-patch"]["prep"]["weekly"]` - auto patching prep occurs once a week
  on the corresponding textual weekday ("monday","tuesday",etc), overrides
  `node["auto-patch"]["prep"]["monthly"]`, defaults to nil
* `node["auto-patch"]["prep"]["update_updater"]` - updates apt or yum before
  actual patching occurs, defaults to true

## Recipes

* `recipe[auto-patch]` configures automatic patching

## Usage

* Change any attributes to fit your patching cycle
* If using auto patch preparation, ensure it starts before auto patch (remember
  any splay!)
* Add `recipe[auto-patch]` to your node's run list

## Contributing

Please use standard Github issues/pull requests.

## License and Author
      
Author:: Brian Flad (<bflad@wharton.upenn.edu>)

Copyright:: 2012

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
