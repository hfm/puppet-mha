class mha::node (
  $manager,
  $version         = $mha::params::node_version,
  $nodes           = [],
  $user            = $mha::params::user,
  $password        = $mha::params::password,
  $repl_user       = $mha::params::repl_user,
  $repl_password   = $mha::params::repl_password,
  $ssh_user        = $mha::params::ssh_user,
  $ssh_key_type    = $mha::params::ssh_key_type,
  $ssh_public_key  = $mha::params::ssh_public_key,
  $ssh_key_path    = $mha::params::ssh_key_path,
  $ssh_private_key = $mha::params::ssh_private_key,
  $cron_ensure     = $mha::params::purge_relay_logs_ensure,
  $cron_user       = $mha::params::purge_relay_logs_user,
  $cron_minute     = $mha::params::purge_relay_logs_minute,
  $cron_hour       = $mha::params::purge_relay_logs_hour,
) inherits mha::params {

  ssh_authorized_key { 'mha::node':
    ensure => present,
    user   => $ssh_user,
    type   => $ssh_key_type,
    key    => $ssh_public_key,
  }

  mha::ssh_private_key { 'mha::node':
    user    => $ssh_user,
    path    => $ssh_key_path,
    content => $ssh_private_key,
    require => Ssh_authorized_key['mha::node'],
  }

  include 'mha::node::install'
  include 'mha::node::grants'
  include 'mha::node::purge_relay_logs'

}
