require 'beaker-rspec'

hosts.each do |host|
  if host.platform.version.to_i == 5
    on(host, 'echo "nameserver 8.8.8.8" >> /etc/resolv.conf')
  end
end

# Install Puppet agent on all hosts
install_puppet_agent_on(hosts, {})

RSpec.configure do |c|
  c.formatter = :documentation
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.before :suite do
    # Install module to all hosts
    install_dev_puppet_module(:source => module_root)

    # Install dependencies
    hosts.each do |host|
      on(host, puppet('module', 'install', 'puppetlabs-stdlib'))
      on(host, puppet('module', 'install', 'puppetlabs-mysql'))
      on(host, puppet('module', 'install', 'proletaryo-supervisor'))
      on(host, puppet('module', 'install', 'stahnma-epel'))
    end
  end
end
