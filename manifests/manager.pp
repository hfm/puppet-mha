class mha::manager (
  $version       = $mha::params::manager_version,
  $node_version  = $mha::params::node_version,
  $script_ensure = $mha::params::script_ensure,
  $ssh_user      = $mha::params::ssh_user,
) inherits mha::params {

  validate_re($version, '^\d+\.\d+-\d+$', "${version} is not supported for version. This parameter should be like '0.57-0'.")
  validate_re($node_version, '^\d+\.\d+-\d+$', "${node_version} is not supported for node_version. This parameter should be like '0.57-0'.")

  include mha::manager::install

  class { 'mha::manager::script':
    ensure => $script_ensure,
  }

}
