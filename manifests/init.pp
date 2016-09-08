#
# = Class: system
#
class system {

  # load hosts, sysctl, sysfs, limits settings
  create_resources(host,       hiera_hash('hosts', {}))
  create_resources('::sysfs',  hiera_hash('sysfs', {}))
  create_resources('::sysctl', hiera_hash('sysctl',{}))
  create_resources('::limits', hiera_hash('limits',{}))
  create_resources('::selinux::module', hiera_hash('selinux::modules',{}))
  create_resources('::rsyslog::remote', hiera_hash('rsyslog::remotes',{}))

  # selinux settings
  create_resources('selboolean', hiera_hash('selinux::selbooleans',{}))
  create_resources('selmodule',  hiera_hash('selinux::selmodules', {}))

  # wheel group container
  group { 'wheel': ensure => present }

}
