class mha::manager::install {

  $ensure        = "${mha::manager::version}.el${::operatingsystemmajrelease}"
  $rpm           = "mha4mysql-manager-${ensure}.noarch.rpm"
  $source_url    = "http://www.mysql.gr.jp/frame/modules/bwiki/index.php?plugin=attach&pcmd=open&file=${rpm}&refer=matsunobu"
  $download_path = "/usr/local/src/${rpm}"

  if !defined(Class['mha::node::install']) {
    class { 'mha::node::install':
      version => $mha::manager::node_version,
    }
  }

  $perl_pkgs = [
    'perl-Config-Tiny',
    'perl-Log-Dispatch',
    'perl-Parallel-ForkManager',
    'perl(Time::HiRes)',
  ]

  ensure_packages($perl_pkgs)
  ensure_packages('wget')

  # Because the rpm command on centos5 is failed.
  exec { "download mha-manager":
    command => "/usr/bin/wget -O ${download_path} \"${source_url}\"",
    creates => $download_path,
    require => Package['wget'],
  }

  package { "mha4mysql-manager":
    ensure   => $ensure,
    provider => rpm,
    source   => $download_path,
    require  => [
      Exec['download mha-manager'],
      Package[$perl_pkgs],
      Class['mha::node::install'],
    ],
  }

}
