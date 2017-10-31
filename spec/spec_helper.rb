require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  c.formatter = :documentation
  c.hiera_config = 'spec/fixtures/hiera.yaml'
  c.default_facts = {
    os: {
      family: 'RedHat',
      release: {
        major: '7',
        minor: '1',
        full: '7.1.1503'
      }
    },
    osfamily: 'redhat',
    operatingsystem: 'CentOS',
    operatingsystemmajrelease: '7'
  }
  c.after(:suite) do
    RSpec::Puppet::Coverage.report!
  end
end
