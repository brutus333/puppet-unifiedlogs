# == Class unifiedlogs::service
#
# This class is meant to be called from unifiedlogs.
# It ensure the service is running.
#
class unifiedlogs::service {
  Sshfsmount <<| |>>
}
