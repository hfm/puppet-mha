define mha::node::grants::repl (
  $host = $name,
  $user,
  $password,
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
