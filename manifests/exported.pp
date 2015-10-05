class unifiedlogs::exported ($user,$dir) {
  @@unifiedlogs::sshfsmount { "${fqdn}_${dir}":
    user    => $user,
    host    => $fqdn,
    dir     => $dir,
  }
}
