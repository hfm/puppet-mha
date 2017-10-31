define mha::node::grants::repl (
  String $user,
  String $password,
  String $host = $name,
) {

  mysql_user { "${user}@${host}":
    password_hash => mysql_password($password),
  }

  mysql_grant {"${user}@${host}/*.*":
    user       => "${user}@${host}",
    table      => '*.*',
    privileges => [
      'REPLICATION SLAVE',
      'REPLICATION CLIENT',
    ],
  }

}
