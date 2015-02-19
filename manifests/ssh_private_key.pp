define mha::ssh_private_key (
  $path,
  $content,
) {

  if $path =~ /^\/root\/.ssh\// {
    ensure_resource('file', '/root/.ssh', {
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => '0700',
      before => File[$path],
    })
  }

  ensure_resource('file', $path, {
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => $content,
  })

}
