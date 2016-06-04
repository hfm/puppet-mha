class mha::manager::install {

  require ::epel

  $ensure        = "${mha::manager::version}.el${::operatingsystemmajrelease}"
  $rpm           = "mha4mysql-manager-${ensure}.noarch.rpm"
  $source_url    = "https://72003f4c60f5cc941cd1c7d448fc3c99e0aebaa8.googledrive.com/host/0B1lu97m8-haWeHdGWXp0YVVUSlk/${rpm}"
  $download_path = "/usr/local/src/${rpm}"

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

  # Because the rpm command on centos5 is failed.
  exec { 'download mha-manager':
    command => "curl -L -o ${download_path} '${source_url}'",
    path    => ['/bin', '/usr/bin', '/usr/local/bin'],
    creates => $download_path,
  }

  package { 'mha4mysql-manager':
    ensure   => $ensure,
    provider => rpm,
    source   => $download_path,
    require  => [
      Exec['download mha-manager'],
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
