class mha::node::install (
  $version
) {

  ensure_packages('perl-DBD-MySQL')

  package {'mha4mysql-node':
    ensure   => installed,
    provider => rpm,
    source   => "http://www.mysql.gr.jp/frame/modules/bwiki/index.php?plugin=attach&pcmd=open&file=mha4mysql-node-${version}${::mha_pkg_suffix}&refer=matsunobu",
    require  => Package['perl-DBD-MySQL'],
  }

}
