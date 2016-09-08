#
# = Class: system::rootkeys
#
# Deploys ssh private and public key for root user from hosts private section.
#
# == Requires
# 'private' section set in auth.conf on master. Definition should look something
# like this:
#
#    [private]
#     path /etc/puppet/private/%H
#     allow *
#
class system::rootkeys(
  $source = 'puppet:///private/rootkeys'
) {
  File {
    ensure => file,
    owner  => root,
    group  => root,
  }

  if ! defined(File['/root/.ssh']) {
    file { '/root/.ssh':
      ensure => directory,
      mode   => '0700',
    }
  }
  file { '/root/.ssh/id_rsa':
    mode   => '0600',
    source => "${source}/id_rsa",
  }
  file { '/root/.ssh/id_rsa.pub':
    mode   => '0644',
    source => "${source}/id_rsa.pub",
  }

}
