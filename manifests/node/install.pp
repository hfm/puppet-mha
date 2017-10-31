class mha::node::install {

  $version  = lookup('mha::node::version')
  $ssh_user = lookup('mha::node::ssh_user')

  $rpm = "mha4mysql-node-${version}.el${facts['operatingsystemmajrelease']}.noarch.rpm"
  $rpm_path = "/usr/local/src/${rpm}"

  ensure_packages('perl-DBD-MySQL')

  file { $rpm_path:
    source => "puppet:///modules/mha/${rpm}",
  }

  package { 'mha4mysql-node':
    provider => rpm,
    source   => $rpm_path,
    require  => Package['perl-DBD-MySQL'],
  }

  file { '/var/log/masterha':
    ensure => directory,
    owner  => $ssh_user,
    mode   => '0755',
  }

}
