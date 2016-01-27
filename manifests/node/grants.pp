class mha::node::grants {

  $nodes = split(inline_template("<%=
    scope.lookupvar('mha::node::nodes') \
      .map {|v| v['hostname'] } \
      .join(',')
  %>"),',')

  $admin_hosts = unique(flatten([
    # for purge_relay_logs. see mha::node::purge_relay_logs
    'localhost',
    $mha::node::manager,
    $nodes
  ]))

  mha::node::grants::admin { $admin_hosts:
    user     => $mha::node::user,
    password => $mha::node::password;
  }

  mha::node::grants::repl { $nodes:
    user     => $mha::node::repl_user,
    password => $mha::node::repl_password;
  }
}
