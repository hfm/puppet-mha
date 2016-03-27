# == Class: mha::node::purge_relay_logs
#
# This class configure the schedule the cron job to run purge_relay_logs script.
#
# === Parameters
#
# * `ensure`
# Whether the cron job should be in. Default to present.
#
# * `cron_user`
# The user who owns the cron job. This user must be allowed to run this job. Default to 'root'.
#
# * `cron_minute`
# The minute at which to run the cron job. Default to '10'.

# * `cron_hour`
# The hour at which to run the cron job. Default to '2-23/6'.
#
class mha::node::purge_relay_logs (
  $ensure = $mha::node::cron_ensure,
  $user   = $mha::node::cron_user,
  $minute = $mha::node::cron_minute,
  $hour   = $mha::node::cron_hour,
) {

  $cmd = "/usr/bin/purge_relay_logs --host localhost --user=${mha::node::user} --password=${mha::node::password} --disable_relay_log_purge"

  # ref: https://code.google.com/p/mysql-master-ha/wiki/Requirements#Schedule_to_run_purge_relay_logs_script
  cron { 'purge relay logs for MHA':
    ensure  => $ensure,
    command => "sleep \$((\$RANDOM\\%60)) && ${cmd} >> /var/log/masterha/purge_relay_logs.log 2>&1",
    user    => $user,
    minute  => $minute,
    hour    => $hour,
  }

}
