# Class: mha::manager::script
# ===========================
#
# Configure mysql_online_switch file to manage.
#
# Parameters
# ----------
#
# * `ensure`
# Whether the mysql_online_switch script should exist.
#
class mha::manager::script (
  $ensure = $mha::manager::script_ensure,
) {

  validate_re($ensure, '\A(absent|present)\Z')

  file { '/usr/bin/mysql_online_switch':
    ensure => $ensure,
    source => 'puppet:///modules/mha/mysql_online_switch',
    mode   => '0755',
  }

}
