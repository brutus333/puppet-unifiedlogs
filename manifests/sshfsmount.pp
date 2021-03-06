# Defined type sshfsmount 
# Example usage:
# @@sshfsmount { "host.local.domain_apache_/var/log/httpd":
#   host => 'host.local.domain',
#   user => 'apache',
#   dir  => '/var/log/apache',
# }
define unifiedlogs::sshfsmount ($host,$user,$dir) {
  $dirs = [ "${::unifiedlogs::hookdir}", "${::unifiedlogs::hookdir}/${host}" ]

  $mountdir = "${::unifiedlogs::hookdir}/${host}"
  
  ensure_resource('file',$dirs,{ ensure => directory })

  service { "sshfs_${host}_${user}_${dir}":
    ensure  => running,
    start   => "sshfs -o ServerAliveInterval=10 -o StrictHostKeyChecking=no -o ro -o allow_other -o follow_symlinks ${user}@${host}:${dir} ${mountdir}",
    stop    => "umount ${mountdir}",
    status  => "mount|grep ${mountdir}",
    require => File[$mountdir],
  }
}
