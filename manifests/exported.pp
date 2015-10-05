# Class unifiedlogs::exported is exporting sshfsmount type resource from one hosts
# starting from a user (for ssh authentication) and one dir
# Label is used to filter collected resources
class unifiedlogs::exported ($user,$dir,$label) {
  @@::unifiedlogs::sshfsmount { "${::fqdn}_${dir}":
    user    => $user,
    host    => $::fqdn,
    dir     => $dir,
    tag     => $label,
  }
}
