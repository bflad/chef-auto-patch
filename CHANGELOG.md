## 0.1.10

* Bugfix: #2 check if constants are already defined

## v0.1.9 ##

* RHEL 5 support with correct package name

## v0.1.8 ##

* Fixed day of month logic for later week specifications

## v0.1.7 ##

* Removed cookbook attribute from cron_d resources since was fixed in [cron@1.2.2](https://github.com/opscode-cookbooks/cron/compare/1.2.0...1.2.2)

## v0.1.6

* Fixed typo in default recipe for platform_family detection

## v0.1.5

* Fixes in default recipe for WARN: Setting attributes without specifying a precedence is deprecated

## v0.1.4

* Defaulted auto-patch splay to 0 since setting is only for large numbers of
  nodes

## v0.1.3

* Refactored next_monthly_*_date functions into next_monthly_date

## v0.1.2

* Convert unnecessary String attributes to Fixnum

## v0.1.1

* Only install yum-plugin-downloadonly if auto-patch prep is enabled.

## v0.1.0

* Initial release with tested Red Hat 6.3 support

## v0.0.1

* Initial cookbook building and testing.
