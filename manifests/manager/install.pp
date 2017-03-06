class mha::manager::install (
  $version      = $mha::manager::version,
  $node_version = $mha::manager::node_version,
  $ssh_user     = $mha::manager::ssh_user,
) {

  require ::epel

  $ensure   = "${version}.el${::operatingsystemmajrelease}"
  $rpm      = "mha4mysql-manager-${ensure}.noarch.rpm"
  $rpm_path = "/usr/local/src/${rpm}"

  if !defined(Class['mha::node::install']) {
    class { 'mha::node::install':
      version  => $node_version,
      ssh_user => $ssh_user,
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
