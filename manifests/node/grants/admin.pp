define mha::node::grants::admin (
  $user,
  $password,
  $host = $name,
) {
  ensure_resource('mysql_user',
    "${user}@${host}",
    {
      password_hash => mysql_password($password),
    }
  )

  ensure_resource('mysql_grant',
    "${user}@${host}/*.*",
    {
      user       => "${user}@${host}",
      table      => '*.*',
      privileges => ['ALL'],
    }
  )
}
