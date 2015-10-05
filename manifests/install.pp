# == Class unifiedlogs::install
#
# This class is called from unifiedlogs for install.
#
class unifiedlogs::install {

  package { $::unifiedlogs::package_name:
    ensure => present,
  }
}
