define mha::ssh_private_key (
  $path,
  $content,
) {

  file { $path:
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => $content,
  }

}
