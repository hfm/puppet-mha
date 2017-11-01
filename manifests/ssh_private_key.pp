define mha::ssh_private_key (
  String $user,
  String $path,
  String $content,
) {

  file { $path:
    owner   => $user,
    mode    => '0600',
    content => $content,
  }

}
