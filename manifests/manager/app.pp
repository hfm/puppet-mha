define mha::manager::app (
  Array[Hash] $nodes,
  String $password,
  String $repl_password,
  String $ssh_private_key,

  String $user = 'root',
  String $repl_user = 'repl',
  Integer $ping_interval = 3,
  String $ping_type = 'SELECT',
  String $ssh_user = 'root',
  Integer $ssh_port = 22,
  String $ssh_key_path = '/root/.ssh/id_mha',
  Hash $default = {},
  Boolean $manage_daemon = false,
) {

  file { "/etc/masterha/${name}.cnf":
    ensure  => present,
    content => template('mha/app.cnf.erb'),
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
  }

  mha::ssh_private_key { "mha::manager::${name}":
    user    => $ssh_user,
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
