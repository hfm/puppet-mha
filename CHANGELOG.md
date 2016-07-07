Release 0.0.12 (2016/06/02)
---

- [Make ping options customizable](https://github.com/hfm/puppet-mha/pull/19)
  - Add params of [ping\_interval](https://code.google.com/p/mysql-master-ha/wiki/Parameters#ping_interval) and [ping\_type](https://code.google.com/p/mysql-master-ha/wiki/Parameters#ping_type)

Release 0.0.11 (2016/05/31)
---

- [Make ssh configuration more customizable by vide](https://github.com/hfm/puppet-mha/pull/18)
  - Add params of [ssh\_user](https://code.google.com/p/mysql-master-ha/wiki/Parameters#ssh_user) and [ssh\_port](https://code.google.com/p/mysql-master-ha/wiki/Parameters#ssh_port)

Release 0.0.10 (2016/03/28)
---

- [Update mha::node classes](https://github.com/hfm/puppet-mha/pull/17)

Release 0.0.9 (2016/03/27)
---

- [Add the parameter to manage script #14](https://github.com/hfm/puppet-mha/pull/14)
- [Move /etc/masterma resource to mha::manager::install class #15](https://github.com/hfm/puppet-mha/pull/15)
- [Add default value to the version of mha::node::install class #16](https://github.com/hfm/puppet-mha/pull/16)

Release 0.0.8 (2016/03/26)
---

- [10d1a4d](https://github.com/hfm/puppet-mha/commit/10d1a4d) Add packages for CentOS7
  - Now mha4mysql-manager can be installed for CentOS7.
  - mha4mysql-node can also.

Release 0.0.7 (2016/03/26)
---

- [18709fa](https://github.com/hfm/puppet-mha/commit/18709fa) Stop using ensure\_resource()

Release 0.0.6 (2016/03/25)
---

- [698281d](https://github.com/hfm/puppet-mha/commit/698281d) Fix: remove wget package from mha::node
- [d77bf06](https://github.com/hfm/puppet-mha/commit/d77bf06) Newer MHA versions (from 0.56) will be hosted on Google Drive instead.

Release 0.0.5 (2016/03/25)
---

- [0fa8b2f](https://github.com/hfm/puppet-mha/commit/0fa8b2f) Use curl instead of wget to download mha-manager
- [662bb1e](https://github.com/hfm/puppet-mha/commit/662bb1e) Remove wget package resource on manifests
- [f429e1c](https://github.com/hfm/puppet-mha/commit/f429e1c) Use ensure params to configure mysql\_online\_switch file to manage
- [385373b](https://github.com/hfm/puppet-mha/commit/385373b) Use file function instead of source


Release 0.0.4 (2016/03/24)
---

- Require epel module in mha::manager::install class.

Release 0.0.3 (2016/03/24)
---

- Add path to wget in mha::manager::install class.

Release 0.0.2 (2016/03/24)
---

- Initial release.

