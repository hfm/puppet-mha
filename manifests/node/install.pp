class mha::node::install (
  $version
) {

  $ensure        = "${version}.el${::operatingsystemmajrelease}"
  $rpm           = "mha4mysql-node-${ensure}.noarch.rpm"
  $source_url    = "http://www.mysql.gr.jp/frame/modules/bwiki/index.php?plugin=attach&pcmd=open&file=${rpm}&refer=matsunobu"
  $download_path = "/usr/local/src/${rpm}"

  ensure_packages(['perl-DBD-MySQL', 'wget'])

  # Because the rpm command on centos5 is failed.
  exec { 'download mha-node':
    command => "/usr/bin/wget -O ${download_path} \"${source_url}\"",
    creates => $download_path,
    require => Package['wget'],
  }

  package { 'mha4mysql-node':
    ensure   => $ensure,
    provider => rpm,
    source   => $download_path,
    require  => [
      Exec['download mha-node'],
      Package['perl-DBD-MySQL'],
    ],
  }

}
