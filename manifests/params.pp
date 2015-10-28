# == Class unifiedlogs::params
#
# This class is meant to be called from unifiedlogs.
# It sets variables according to platform.
#
class unifiedlogs::params {
  $hookdir = '/mnt'
  $user    = undef
  $label   = undef
  $dir     = undef
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
