class mha::manager::script {

  file { '/usr/bin/mysql_online_switch':
    content => file('mha/usr/bin/mysql_online_switch'),
    mode   => '0755',
  }

}
