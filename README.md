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
  - [Parameters](#parameters)
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

To install the MHA manager with default parameters, declare the `mha::manager` class.

```puppet
include '::mha::manager'
```

To install the MHA node (libnss\_mha and libpam\_mha) with default parameters, declare the `mha::node` class.

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
  ssh_key_path    => '/etc/masterha/key/private.key',
  ssh_private_key => '-----BEGIN RSA PRIVATE KEY-----
...
-----END RSA PRIVATE KEY-----',
  ssh_public_key  => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtnFFI/ICCBmr4LY0gIgyF3Jex20KwTFT67aoNGxAvjRSsg9d+c0/sxq0oBZSdgLoRrlnSu226mvv89E6dnc61JFbJpWN6et8qTW75e2/cU/DIe2vS3nTBcBvgj23oF2c5Wv7Vy2FacdDXaLa7tKmAnetI7FT+0IwmR7FMCvREmOqn4eCTkoUNXdLHqkQ0f2SSYBUUyno68nUM1bXgc63bQU8T1tr8kZ2t3NHpAa8YEYraKbCltsBkyqr7FExe5o23RyML4NuKfa1UllJhZO3IrQgbiAXsIFZpEqbcL8tObQ55nQIrNzZEvHoDN7K7jZP4WdjfTF26xSqJ+LrlGsRV',
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
mha::node::ssh_key_path: '/etc/masterha/key/private.key'
mha::node::ssh_private_key: |
-----BEGIN RSA PRIVATE KEY-----
...
-----END RSA PRIVATE KEY-----
mha::node::ssh_public_key: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtnFFI/ICCBmr4LY0gIgyF3Jex20KwTFT67aoNGxAvjRSsg9d+c0/sxq0oBZSdgLoRrlnSu226mvv89E6dnc61JFbJpWN6et8qTW75e2/cU/DIe2vS3nTBcBvgj23oF2c5Wv7Vy2FacdDXaLa7tKmAnetI7FT+0IwmR7FMCvREmOqn4eCTkoUNXdLHqkQ0f2SSYBUUyno68nUM1bXgc63bQU8T1tr8kZ2t3NHpAa8YEYraKbCltsBkyqr7FExe5o23RyML4NuKfa1UllJhZO3IrQgbiAXsIFZpEqbcL8tObQ55nQIrNzZEvHoDN7K7jZP4WdjfTF26xSqJ+LrlGsRV'
```

## Reference

### Public Classes

- [`mha::manager`](#mhamanager): Installs and configures MHA.
- [`mha::node`](#mhaclient): Installs and configures libnss\_mha and libpam\_mha.

### Private Classes

- `mha::repo`: Setup MHA repository.
- `mha::manager::install`: Install mha4mysql-manager.
- `mha::manager::script`: Install MHA.
- `mha::node::install`: Installs packages for libnss\_mha and libpam\_mha.
- `mha::node::config`: Configures

### Defined Types

- `mha::manager::users`: Specifies a MHA users configuration file.
- `mha::manager::groups`: Specifies a MHA groups configuration file.

### Parameters

#### Class: `mha::manager`

- `port`: Specifies a listen port listen. Valid options: a number of a port number. Default: 1104.
- `user`: Specifies a user for authentication. Valid options: a string containing a valid username. Default: 'undef'.
- `password`: Specifies a password for authentication. Valid options: a string containing a valid password. Default: 'undef'.

#### Class: `mha::node`

- `api_end_point`: Valid options: Default: 'http://localhost:1104'.
- `user`: Specifies a user for authentication. Valid options: a string containing a valid username. Default: 'undef'.
- `password`: Specifies a password for authentication. Valid options: a string containing a valid password. Default: 'undef'.
- `wrapper_path`: Valid options: absolute path. Default: '/usr/local/bin/mha-query-wrapper'.
- `chain_ssh_wrapper`: Default: 'undef'.
- `ssl_verify`: Enables SSL verification. Valid options: a boolean. Default: true.
- `handle_nsswitch`: Configure nsswitch.conf to use MHA. Valid options: a boolean. Default: false.
- `handle_sshd_config`: Configure sshd\_config to use MHA. Valid options: a boolean. Default: false.

#### Defined Types: `mha::manager::users`

- `id`: Specifies the user ID. Valid options: a number type. Default: undef.
- `group_id`: Specifies the user's primary group. Valid options: a number type. Default: undef.
- `directory`: Specifies the home directory of the user. Valid options: a string containing a valid path. Default: `/home/<resource title>`.
- `shell`: Specifies the user's login shell. Valid options: a string containing a valid path. Default: `/bin/bash`.
- `keys`: Specify user attributes in an array of key = value pairs. Valid options: a string containing a valid key = value pairs. Default: undef.
- `link_users`: Valid options: a string containing a valid password. Default: undef.

#### Defined Types: `mha::manager::groups`

- `id`: Specifies the group ID. Valid options: a number type. Default: undef.
- `users`: Specifies the members of the group. Valid options: a string containing a valid password. Default: undef.

##### Parameters

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
