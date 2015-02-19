define mha::ssh_keys (
  $type,
  $private_key,
  $public_key,
  $key_path,
) {

  ensure_resource('file', $key_path, {
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => $private_key,
  })

  ensure_resource('ssh_authorized_key', $name, {
    ensure => present,
    user   => 'root',
    type   => $type,
    key    => $public_key,
  })

}
