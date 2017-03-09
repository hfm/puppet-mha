class mha::node::install (
  $version  = $mha::node::version,
  $ssh_user = $mha::node::ssh_user,
) {

  $ensure   = "${version}.el${::operatingsystemmajrelease}"
  $rpm      = "mha4mysql-node-${ensure}.noarch.rpm"
  $rpm_path = "/usr/local/src/${rpm}"

  ensure_packages('perl-DBD-MySQL')

  file { $rpm_path:
    source => "puppet:///modules/mha/${rpm}",
  }

  package { 'mha4mysql-node':
    provider => rpm,
    source   => $rpm_path,
    require  => [
      File[$rpm_path],
      Package['perl-DBD-MySQL'],
    ],
  }

  file { '/var/log/masterha':
    ensure => directory,
    owner  => $ssh_user,
    mode   => '0755',
  }

}
