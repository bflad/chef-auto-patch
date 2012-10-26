name              "auto-patch"
maintainer        "The Wharton School - The University of Pennsylvania"
maintainer_email  "chef-admins@wharton.upenn.edu"
license           "Apache 2.0"
description       "Configures node for automatic patching."
version           "0.0.1"
recipe            "auto-patch", "Configures node for automatic patching."

%w{ cron }.each do |d|
  depends d
end

%w{ amazon centos debian fedora redhat scientific ubuntu }.each do |os|
  supports os
end
