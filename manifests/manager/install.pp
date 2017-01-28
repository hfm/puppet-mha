class mha::manager::install {

  require ::epel

  $ensure   = "${mha::manager::version}.el${::operatingsystemmajrelease}"
  $rpm      = "mha4mysql-manager-${ensure}.noarch.rpm"
  $rpm_path = "/usr/local/src/${rpm}"

  if !defined(Class['mha::node::install']) {
    class { 'mha::node::install':
      version => $mha::manager::node_version,
    }
  }

  $perl_pkgs = $::operatingsystemmajrelease ? {
    '5'     => [
      'perl-Config-Tiny',
      'perl-Log-Dispatch',
      'perl-Parallel-ForkManager',
    ],
    default => [
      'perl-Config-Tiny',
      'perl-Log-Dispatch',
      'perl-Parallel-ForkManager',
      'perl-Time-HiRes',
    ],
  }

  ensure_packages($perl_pkgs)

  file { $rpm_path:
    source => "puppet:///modules/mha/${rpm}",
  }

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

}
