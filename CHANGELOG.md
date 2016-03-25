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

