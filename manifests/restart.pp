#
# = Define: system::restart
#
# Sets hourly/daily/weekly/monthly restart of a service
define system::restart (
  $template = 'system/restart_service.erb',
  $schedule = 'daily',
  $reason   = 'lower memory footprint',
  ){

  file { "/etc/cron.${schedule}/restart_${name}":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0755',
    content => template($template),
  }

}
