# Class unifiedlogs::exported is exporting sshfsmount type resource from one hosts
# starting from a user (for ssh authentication) and one dir
class unifiedlogs::exported ($user,$dir) {
  @@unifiedlogs::sshfsmount { "${fqdn}_${dir}":
    user    => $user,
    host    => $fqdn,
    dir     => $dir,
  }
}
