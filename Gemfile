source 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? "#{ENV['PUPPET_VERSION']}" : ['>= 3.3']
gem 'puppet', puppetversion

group :test, :development do
  gem 'puppetlabs_spec_helper', '>= 1.0.0', require: false
  gem 'puppet-lint', '>= 1.0.0',            require: false
  gem 'facter', '>= 2.0.1',                 require: false
  gem 'metadata-json-lint',                 require: false
end

group :development do
  gem 'librarian-puppet',  require: false
  gem 'puppet-blacksmith', require: false
end

group :system_tests do
  gem 'beaker',       require: false
  gem 'beaker-rspec', require: false
end

# rspec must be v2 for ruby 1.8.7
if RUBY_VERSION >= '1.8.7' and RUBY_VERSION < '1.9'
  gem 'rspec', '~> 2.0'
end
