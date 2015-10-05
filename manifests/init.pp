# Class: unifiedlogs
# ===========================
#
# Class unified logs is collecting the sshfsmount resources
# on one (or more) host(s) in order to mount the remote directories via sshfs on this(these) host(s)
#
# Parameters
# ----------
#
# * $package_name: 
#   The name of sshfs package (it should rely on what is setup in params class)
# * $hookdir:  
#   The name of the directory hierarchy under each the remote dirs are mounted
# * $label:
#   A label used to restrict the collection of exported resources
class unifiedlogs (
  $package_name = $::unifiedlogs::params::package_name,
  $hookdir = $::unifiedlogs::params::hookdir,
  $label = '',
) inherits ::unifiedlogs::params {


  # validate parameters here

  class { '::unifiedlogs::install': } ->
  class { '::unifiedlogs::service': label => $label, } ->
  Class['::unifiedlogs']
}
