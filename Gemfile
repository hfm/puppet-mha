source 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? "#{ENV['PUPPET_VERSION']}" : ['>= 4.9']
gem 'puppet', puppetversion

group :test, :development do
  gem 'puppetlabs_spec_helper', require: false
  gem 'puppet-lint',            require: false
  gem 'facter',                 require: false
  gem 'metadata-json-lint',     require: false
end

gem 'puppet-blacksmith', require: false, group: :development
gem 'beaker-rspec', require: false, group: :system_tests
