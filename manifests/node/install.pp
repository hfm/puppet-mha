class mha::node::install (
  $version
) {

  $suffix = mha_pkg_suffix()

  package { 'perl-DBD-MySQL':
    require => Package['MySQL-Shared'],
  }

  package {'mha4mysql-node':
    ensure   => installed,
    provider => rpm,
    source   => "https://mysql-master-ha.googlecode.com/files/mha4mysql-node-${version}${suffix}",
    require  => Package['perl-DBD-MySQL'],
  }

}
