# == Class unifiedlogs::params
#
# This class is meant to be called from unifiedlogs.
# It sets variables according to platform.
#
class unifiedlogs::params {
  $hookdir = '/mnt'
  case $::osfamily {
    'Debian': {
      $package_name = 'sshfs'
    }
    'RedHat', 'Amazon': {
      $package_name = 'fuse-sshfs'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
