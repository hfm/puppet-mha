class mha::node (
  $manager,
  $version         = $mha::params::node_version,
  $nodes           = [],
  $user            = $mha::params::user,
  $password        = $mha::params::password,
  $repl_user       = $mha::params::repl_user,
  $repl_password   = $mha::params::repl_password,
  $ssh_key_path    = $mha::params::ssh_key_path,
  $ssh_key_type    = $mha::params::ssh_key_type,
  $ssh_public_key  = $mha::params::ssh_public_key,
  $ssh_private_key = $mha::params::ssh_private_key,
  $purge_relay_logs_schedule = $mha::params::purge_relay_logs_schedule,
) inherits mha::params {

  # if puppetlabs-mysql is used, and mysql::server class is included with service_manage parameter(default true)
  # ref https://github.com/puppetlabs/puppetlabs-mysql/blob/master/manifests/server/service.pp#L10
  if $::mysql::server::real_service_manage {
    $service_name = $::mysql::server::service_name
  } else {
    $service_name = 'mysql'
  }

  mha::ssh_private_key { 'mha::node':
    path    => $ssh_key_path,
    content => $ssh_private_key,
  }

  ensure_resource('ssh_authorized_key', 'mha::node', {
    'ensure' => 'present',
    'user'   => 'root',
    'type'   => $ssh_key_type,
    'key'    => $ssh_public_key,
  })

  Service[$service_name]
  -> class { 'mha::node::install': version => $version }
  -> class { 'mha::node::grants': }
  -> class { 'mha::node::purge_relay_logs': }

}
