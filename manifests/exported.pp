# Class unifiedlogs::exported is exporting sshfsmount type resource from one hosts
# starting from a user (for ssh authentication) and one dir
# Label is used to filter collected resources
class unifiedlogs::exported (
  $user  = $unifiedlogs::params::user,
  $dir   = $unifiedlogs::params::dir,
  $label = $unifiedlogs::params::label) {
  if $user and $dir and $label {
    file { $dir:
      ensure => directory,
      owner  => $user,
    }
    @@::unifiedlogs::sshfsmount { "${::fqdn}_${dir}":
      user    => $user,
      host    => $::fqdn,
      dir     => $dir,
      tag     => $label,
    }
  }
}
