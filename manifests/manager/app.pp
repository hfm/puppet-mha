define mha::manager::app (
  $nodes           = [],
  $user            = $mha::params::user,
  $password        = $mha::params::password,
  $repl_user       = $mha::params::repl_user,
  $repl_password   = $mha::params::repl_password,
  $ssh_key_path    = $mha::params::ssh_key_path,
  $ssh_private_key = $mha::params::ssh_private_key,
  $default         = {},
  $manage_daemon   = false
) {

  include mha::params

  $config = "/etc/masterha/${name}.cnf"

  ensure_resource('file', '/etc/masterha', {
    ensure => directory,
    mode   => 755,
  })

  file { $config:
    content => template('mha/etc/masterha/app.cnf'),
    mode    => 600,
    owner   => 'root',
    group   => 'root',
  }

  mha::ssh_private_key { "mha::manager::$name":
    path    => $ssh_key_path,
    content => $ssh_private_key,
  }

  if $manage_daemon {
    include supervisor

    supervisor::program { "masterha_manager_${name}":
      ensure                 => present,
      enable                 => true,
      command                => "/usr/bin/masterha_manager --conf=${config}",
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

