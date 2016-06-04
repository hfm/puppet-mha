puppet-mha
===

[![Build Status](https://img.shields.io/travis/hfm/puppet-mha/master.svg?style=flat-square)](https://travis-ci.org/hfm/puppet-mha)
[![Puppet Forge](https://img.shields.io/puppetforge/v/hfm/mha.svg?style=flat-square)](https://forge.puppetlabs.com/hfm/mha)

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with MHA](#setup)
  - [Setup requirements](#setup-requirements)
  - [Beginning with MHA](#beginning-with-mha)
1. [Usage - Configuration options and additional functionality](#usage)
  - [Configuring mha::manager](#configuring-mhamanager)
  - [Configuring mha::node](#configuring-mhanode)
  - [Configuring modules from Hiera](#configuring-modules-from-hiera)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
  - [Public Classes](#public-classes)
  - [Private Classes](#private-classes)
  - [Defined Types](#defined-types)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)
  - [Running tests](#running-tests)
  - [Testing quickstart](#testing-quickstart)
  - [Smoke tests](#smoke-tests)

## Description

The MHA module handles installing, configuring, and running [MHA for MySQL](https://code.google.com/p/mysql-master-ha/).

## Setup

### Setup Requirements

The MHA module requires the following puppet modules:

- [puppetlabs-stdlib](https://forge.puppet.com/puppetlabs/stdlib): version 3.0.0 or newer.
- [puppetlabs-mysql](https://forge.puppet.com/puppetlabs/mysql): version 3.5.0 or newer.
- [proletaryo-supervisor](https://forge.puppet.com/provision/supervisor): version 0.5.0 - 0.6.0.
- [stahnma-epel](https://forge.puppet.com/stahnma/epel): version 1.0.0 or newer.

### Beginning with MHA

To install the mha4mysql-manager with default parameters, declare the `mha::manager` class.

```puppet
include '::mha::manager'
```

To install the mha4mysql-node with default parameters, declare the `mha::node` class.

```puppet
include '::mha::node'
```

## Usage

### Configuring mha::manager

```puppet
class { '::mha::manager':
  version       => '0.57-0',
  node_version  => '0.57-0',
  script_ensure => present,
}
```

### Configuring mha::node

```puppet
class { '::mha::node':
  user            => 'mha',
  password        => 'mysq1m@$terh@',
  repl_user       => 'replicator',
  repl_password   => 'rep1ic@t1r',
  manager         => 'master-ha.example.com',
  nodes           => [
    {
      'hostname'         => 'node001.example.com',
      'candidate_master' => 1,
    },
    {
      'hostname'         => 'node002.example.com',
      'candidate_master' => 1,
    },
    {
      'hostname'         => 'node003.example.com',
    },
  ],
  ssh_private_key => '-----BEGIN RSA PRIVATE KEY-----
...
-----END RSA PRIVATE KEY-----',
  ssh_key_type    => 'ssh-rsa',
  ssh_public_key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCtnFFI/ICCBmr4LY0gIgyF3Jex20KwTFT67aoNGxAvjRSsg9d+c0/sxq0oBZSdgLoRrlnSu226mvv89E6dnc61JFbJpWN6et8qTW75e2/cU/DIe2vS3nTBcBvgj23oF2c5Wv7Vy2FacdDXaLa7tKmAnetI7FT+0IwmR7FMCvREmOqn4eCTkoUNXdLHqkQ0f2SSYBUUyno68nUM1bXgc63bQU8T1tr8kZ2t3NHpAa8YEYraKbCltsBkyqr7FExe5o23RyML4NuKfa1UllJhZO3IrQgbiAXsIFZpEqbcL8tObQ55nQIrNzZEvHoDN7K7jZP4WdjfTF26xSqJ+LrlGsRV',
}
```

### Configuring modules from Hiera

```yaml
---
mha::manager::version: '0.57-0'
mha::manager::node_version: '0.57-0'

mha::node::user: 'mha'
mha::node::password: 'mysq1m@$terh@'
mha::node::repl_user: 'replicator'
mha::node::repl_password: 'rep1ic@t0r'
mha::node::manager: 'master-ha.example.com'
mha::node::nodes:
  - hostname: 'node001.example.com'
    candidate_master: 1
  - hostname: 'node002.example.com'
    candidate_master: 1
  - hostname: 'node003.example.com'
mha::node::ssh_key_type: 'ssh-rsa'
mha::node::ssh_public_key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCtnFFI/ICCBmr4LY0gIgyF3Jex20KwTFT67aoNGxAvjRSsg9d+c0/sxq0oBZSdgLoRrlnSu226mvv89E6dnc61JFbJpWN6et8qTW75e2/cU/DIe2vS3nTBcBvgj23oF2c5Wv7Vy2FacdDXaLa7tKmAnetI7FT+0IwmR7FMCvREmOqn4eCTkoUNXdLHqkQ0f2SSYBUUyno68nUM1bXgc63bQU8T1tr8kZ2t3NHpAa8YEYraKbCltsBkyqr7FExe5o23RyML4NuKfa1UllJhZO3IrQgbiAXsIFZpEqbcL8tObQ55nQIrNzZEvHoDN7K7jZP4WdjfTF26xSqJ+LrlGsRV'
mha::node::ssh_private_key: |
-----BEGIN RSA PRIVATE KEY-----
...
-----END RSA PRIVATE KEY-----
```

## Reference

### Public Classes

#### `mha::manager`

Install and configure mha4mysql-manager, and install the mysql\_online\_switch script.

- `version`: Specify a mha4mysql-manager version. Valid values is 'x.y-z' like '0.57-0'.
- `node_version`: Specify a mha4mysql-node version. Valid values is 'x.y-z' like '0.57-0'.
- `script_ensure`: Whether the mysql\_online\_switch script should exist. Default to present.

#### `mha::node`

Install and configure mha4mysql-node, create grant permissions to access MySQL for administrator and replicator, configure the cron job to run purge\_relay\_logs script, and install a ssh key-pair.

- `manager`: Specify the host for mha4mysql-manager. Default to undef.
- `version`: Specify the mha4mysql-node version. Valid values is 'x.y-z' like '0.57-0'.
- `nodes`: Specify the hostname or ip address of the target MySQL server. Default to [].
- `user`: The MySQL administrative database username. Default: 'root'.
- `password`: The MySQL password of the "$user" user. Default to '' (empty).
- `repl_user`: The MySQL replication username. Default to 'repl'.
- `repl_password`: The MySQL password of the repl user. Default: '' (empty).
- `ssh_key_type`: The encryption type used.
- `ssh_public_key`: The public key itself.
- `ssh_key_path`: The path to the private key.
- `ssh_private_key`: The private key itself.
- `cron_ensure`: Whether the cron job should be in. Default to present.
- `cron_user`: The user who owns the cron job. This user must be allowed to run this job. Default to 'root'.
- `cron_minute`: The minute at which to run the cron job. Default to '10'.
- `cron_hour`: The hour at which to run the cron job. Default to '2-23/6'.

### Private Classes

- `mha::manager::install`: Install mha4mysql-manager package.
- `mha::manager::script`: Install mysql\_online\_switch.
- `mha::node::grants`: Create grant permissions to access MySQL for administrator and replicator.
- `mha::node::install`: Install mha4mysql-node package.
- `mha::node::purge_relay_logs`: Configure the cron job to run purge\_relay\_logs script.

### Defined Types

#### `mha::manager::app`

Set up an application configuration file.

- `nodes`: Specify the hostname or ip address of the target MySQL server. Default to [].
- `user`: The MySQL administrative database username. Default: 'root'.
- `password`: The MySQL password of the "$user" user. Default to '' (empty).
- `repl_user`: The MySQL replication username. Default to 'repl'.
- `repl_password`: The MySQL password of the repl user. Default: '' (empty).
- `ping_interval`: Default to '3'.
- `ping_type`: Default to 'SELECT'.
- `ssh_user`: Default to 'root'.
- `ssh_port`: Default to '22'.
- `ssh_key_path`: The path to the private key. Default to '/root/.ssh/id\_mha',
- `ssh_private_key`: The private key itself.
- `default`: Default to {}.
- `manage_daemon`: Default to false.

#### `mha::node::grants::admin`

Create grant permissions to access MySQL for administrator.

- `host`: The host to use as part of user@host for grants. Default is a resource name (`$name`).
- `user`: The MySQL administrative database username. Default: undef.
- `password`: The MySQL password of the "$user" user.  Default: undef.

#### `mha::node::grants::repl`

Create grant permissions to access MySQL for replicator.

- `host`: The host to use as part of user@host for grants. Default is a resource name (`$name`).
- `user`: The MySQL replication username. Default: undef.
- `password`: The MySQL password of the repl user. Default: undef.

## Limitations

This module has been tested on:

- RedHat Enterprise Linux 5, 6, 7
- CentOS 5, 6, 7
- Scientific Linux 5, 6, 7

## Development

### Running tests

The MHA puppet module contains tests for both [rspec-puppet](http://rspec-puppet.com/) (unit tests) and [beaker-rspec](https://github.com/puppetlabs/beaker-rspec) (acceptance tests) to verify functionality.
For detailed information on using these tools, please see their respective documentation.

#### Testing quickstart

- Unit tests:

```console
$ bundle install
$ bundle exec rake
```

- Acceptance tests:

```console
# Set your DOCKER_HOST variable
$ eval "$(docker-machine env default)"

# List available beaker nodesets
$ bundle exec rake beaker_nodes
centos6
centos7

# Run beaker acceptance tests
$ BEAKER_set=centos7 bundle exec rake beaker
```

#### Smoke tests

You can run smoke tests using [Vagrant](https://www.vagrantup.com/):

```console
$ vagrant up <vm> --provision
```

### Authors

- [KURODA Ryo](https://github.com/lamanotrama)
- [OKUMURA Takahiro](https://github.com/hfm)
