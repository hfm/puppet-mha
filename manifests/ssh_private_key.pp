define mha::ssh_private_key (
  $path,
  $content,
) {

  validate_absolute_path($path)

  file { $path:
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => $content,
  }

}
