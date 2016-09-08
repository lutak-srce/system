#
# = Class: system::iptables
#
class system::iptables (
  $source = 'puppet:///system/iptables',
  ){

  include ::rsyslog

  case $::operatingsystemrelease {
    default: {}
    /^6.*/: {
      file { '/etc/rsyslog.d/netfilter.conf':
        ensure => file,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///modules/system/rsyslog_netfilter.conf',
        notify => Service['rsyslog'],
      }
    }
    /^7.*/: {
      package { 'firewalld': ensure => absent }
      package { 'iptables-services': ensure => installed }
    }
  }

  file { '/etc/sysconfig/iptables':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0600',
    source => $source,
  }

  service { 'iptables':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/sysconfig/iptables'],
  }

}
