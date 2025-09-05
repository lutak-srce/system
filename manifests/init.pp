#
# = Class: system
#
class system {

  # load hosts, sysctl, sysfs, limits settings
  create_resources( host, lookup( 'hosts', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}))
  create_resources( '::sysfs', lookup( 'sysfs', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}))
  create_resources( '::sysctl', lookup( 'sysctl', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}))
  create_resources( '::limits', lookup( 'limits', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}))
  create_resources( '::selinux::module', lookup( 'selinux::modules', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}))
  create_resources( '::rsyslog::remote', lookup( 'rsyslog::remotes', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}))

  # selinux settings
  create_resources( 'selboolean', lookup( 'selinux::selbooleans', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}))
  create_resources( 'selmodule', lookup( 'selinux::selmodules', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}))

  # wheel group container
  group { 'wheel': ensure => present }

}
