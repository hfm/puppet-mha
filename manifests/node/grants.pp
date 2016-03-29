class mha::node::grants {

  $nodes = split(inline_template("<%= scope['mha::node::nodes'].map {|v| v['hostname'] }.join(',') %>"), ',')

  # localhost is needed for mha::node::purge_relay_logsa class to run purge_relay_logs.
  $admin_hosts = unique(flatten([ 'localhost', $mha::node::manager, $nodes ]))

  mha::node::grants::admin { $admin_hosts:
    user     => $mha::node::user,
    password => $mha::node::password,
  }

  mha::node::grants::repl { $nodes:
    user     => $mha::node::repl_user,
    password => $mha::node::repl_password,
  }

}
