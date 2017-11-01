class mha::manager (
  String $ensure,
  String $version,
  String $node_version,
  String $script_ensure,
  String $ssh_user,
) {

  require ::epel

  $rpm = "mha4mysql-manager-${version}.el${facts['operatingsystemmajrelease']}.noarch.rpm"
  $rpm_path = "/usr/local/src/${rpm}"

  if !defined(Class['mha::node::install']) {
    include 'mha::node::install'
  }

  file { $rpm_path:
    source => "puppet:///modules/mha/${rpm}",
  }

  $perl_pkgs = [
    'perl-Config-Tiny',
    'perl-Log-Dispatch',
    'perl-Parallel-ForkManager',
    'perl-Time-HiRes',
  ]

  ensure_packages($perl_pkgs)

  package { 'mha4mysql-manager':
    ensure   => $ensure,
    provider => rpm,
    source   => $rpm_path,
    require  => [
      Package[$perl_pkgs],
      Class['mha::node::install'],
    ],
  }

  file { '/etc/masterha':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/usr/bin/mysql_online_switch':
    ensure => $script_ensure,
    source => 'puppet:///modules/mha/mysql_online_switch',
    mode   => '0755',
  }

}
