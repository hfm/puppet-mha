class mha::node (
  String $manager,
  String $version,
  Array $nodes,
  String $user,
  String $password,
  String $repl_user,
  String $repl_password,
  String $ssh_user,
  String $ssh_key_type,
  String $ssh_public_key,
  String $ssh_key_path,
  String $ssh_private_key,
  String $cron_ensure,
  String $cron_user,
  String $cron_minute,
  String $cron_hour,
) {

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
