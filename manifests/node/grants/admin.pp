define mha::node::grants::admin (
  $user,
  $password,
  $host = $name,
) {

  mysql_user { "${user}@${host}":
    password_hash => mysql_password($password),
  }

  mysql_grant { "${user}@${host}/*.*":
    user       => "${user}@${host}",
    table      => '*.*',
    privileges => ['ALL'],
  }

}
