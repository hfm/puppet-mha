class mha::node (
  $manager,
  $version       = $mha::params::node_version,
  $nodes         = [],
  $user          = $mha::params::user,
  $password      = $mha::params::password,
  $repl_user     = $mha::params::repl_user,
  $repl_password = $mha::params::repl_password,
  $ssh           = $mha::params::ssh,
  $purge_relay_logs_schedule = $mha::params::purge_relay_logs_schedule,
) inherits mha::params {

  # if puppetlabs-mysql is used, and mysql::server class is included with service_manage parameter(default true)
  # ref https://github.com/puppetlabs/puppetlabs-mysql/blob/master/manifests/server/service.pp#L10
  if $mysql::server::real_service_manage {
    $service_name = $mysql::server::service_name
  } else {
    $service_name = 'mysql'
  }

  create_resources(
    'mha::ssh_keys',
    { 'mha::node' => $ssh },
    { 'key_path' => '/root/.ssh/id_mha' }, # default
  )

     Service[$service_name]
  -> class { 'mha::node::install': version => $version }
  -> class { 'mha::node::grants': }
  -> class { 'mha::node::purge_relay_logs': }

}
