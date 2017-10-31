source 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? "#{ENV['PUPPET_VERSION']}" : ['>= 4.9']
gem 'puppet', puppetversion

group :test, :development do
  gem 'puppetlabs_spec_helper', require: false
  gem 'puppet-lint',            require: false
  gem 'facter',                 require: false
  gem 'metadata-json-lint',     require: false
end

group :development do
  gem 'librarian-puppet',  require: false
  gem 'puppet-blacksmith', require: false
end

group :system_tests do
  gem 'beaker',       require: false
  gem 'beaker-rspec', require: false
end
