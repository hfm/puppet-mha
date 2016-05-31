define mha::manager::app (
  $nodes           = [],
  $user            = $mha::params::user,
  $password        = $mha::params::password,
  $repl_user       = $mha::params::repl_user,
  $repl_password   = $mha::params::repl_password,
  $ssh_user        = $mha::params::ssh_user,
  $ssh_port        = $mha::params::ssh_port,
  $ssh_key_path    = $mha::params::ssh_key_path,
  $ssh_private_key = $mha::params::ssh_private_key,
  $default         = {},
  $manage_daemon   = false
) {

  include mha::params

  file { "/etc/masterha/${name}.cnf":
    ensure  => present,
    content => template('mha/app.cnf.erb'),
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
  }

  mha::ssh_private_key { "mha::manager::${name}":
    path    => $ssh_key_path,
    content => $ssh_private_key,
  }

  if $manage_daemon {
    include supervisor

    supervisor::program { "masterha_manager_${name}":
      ensure                 => present,
      enable                 => true,
      command                => "/usr/bin/masterha_manager --conf=/etc/masterha/${name}.cnf",
      startsecs              => 10,
      autorestart            => true,
      user                   => 'root',
      group                  => 'root',
      stdout_logfile         => '/var/log/supervisor/%(program_name)s.log',
      stdout_logfile_maxsize => '50MB',
      stdout_logfile_backups => 10,
      redirect_stderr        => true,
      require                => Class['mha::manager'],
    }
  }

}
