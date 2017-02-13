class mha::node::install (
  $version = $mha::node::version,
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
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

}
