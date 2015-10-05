# Defined type sshfsmount 
# Example usage:
# @@sshfsmount { "host.local.domain-apache-/var/log/httpd":
#   host => 'host.local.domain',
#   user => 'apache',
#   dir  => '/var/log/apache',
# }
define unifiedlogs::sshfsmount ($host,$user,$dir) {
  $dirs = [ "$::unifiedlogs::params::hookdir/$host", "$::unifiedlogs::params::hookdir/$host/$dir" ]
  $mountdir = "$::unifiedlogs::params::hookdir/$host/$dir"
  file { $dirs:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  service { "sshfs-$host-$user-$dir":
    start   => "sshfs -o ro -o allow_other $user@$host:$dir $mountdir",
    stop    => "umount $mountdir",
    status  => "mount|grep $mountdir",
    require => File[$mountdir],
    ensure  => running,
  }
}
