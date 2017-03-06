define mha::ssh_private_key (
  $user,
  $path,
  $content,
) {

  validate_string($user)
  validate_absolute_path($path)

  file { $path:
    owner   => $user,
    mode    => '0600',
    content => $content,
  }

}
