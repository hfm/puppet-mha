# -*- mode: ruby -*-
# vi: set ft=ruby :

module VagrantPlugins
  module LibrarianPuppet
    class Plugin < Vagrant.plugin(2)
      name 'vagrant-librarian-puppet'
      description 'Installation of Puppet modules via librarian-puppet'
      action_hook 'librarian_puppet' do |hook|
        hook.before Vagrant::Action::Builtin::Provision, Action
      end
    end

    class Action
      def initialize(app, _)
        @app = app
      end

      def call(env)
        env[:ui].info 'Running pre-provisioner: librarian-puppet...'

        Vagrant::Util::Env.with_clean_env do
          ENV.reject! {|_,v| v.match /vagrant/i}
          cmd = 'bundle exec librarian-puppet install --path tests/modules --verbose'
          env[:ui].detail `#{cmd}`
        end

        @app.call(env)
      end
    end
  end
end


platforms = {
  centos6: 'puppetlabs/centos-6.6-64-puppet',
  centos7: 'puppetlabs/centos-7.2-64-puppet',
  jessie: 'puppetlabs/debian-8.2-64-puppet',
}

Vagrant.configure(2) do |config|
  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
  end

  require 'fileutils'
  FileUtils.mkdir_p 'tests/modules'

  require 'json'
  metadata = JSON.parse(File.read('metadata.json'))
  module_name = metadata['name'].split('-').last

  config.vm.provision :shell,
    inline: "ln -sfn /vagrant/ /vagrant/tests/modules/#{module_name}"

  config.vm.provision :puppet do |puppet|
    puppet.environment_path = '.'
    puppet.environment      = 'tests'
    puppet.module_path      = 'tests/modules'
    puppet.options          = [
      '--detailed-exitcodes',
      '--show_diff',
      '--verbose',
      # '--debug',
    ]
    puppet.hiera_config_path = 'tests/hiera.yaml'
  end

  def define_vbox(c, private_ip: nil, memory: 256, cpu: 2)
    c.vm.network :private_network, ip: private_ip if private_ip

    c.vm.provider :virtualbox do |vbox|
      vbox.customize ["modifyvm", :id, "--memory", memory]
      vbox.customize ["modifyvm", :id, "--cpus",   cpu]

      vbox.customize ["modifyvm", :id, "--hpet", "on"]
      vbox.customize ["modifyvm", :id, "--acpi", "off"]

      vbox.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
      vbox.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
    end
  end

  platforms.each do |dist, box|
    1.upto(3) do |i|
      config.vm.define "#{dist}_node#{i}".to_s do |c|
        c.vm.box       = box
        c.vm.host_name = "#{dist}-node#{i}"
        define_vbox c, private_ip: "192.168.33.2#{i}"
      end
    end

    config.vm.define "#{dist}_manager".to_s do |c|
      c.vm.box       = box
      c.vm.host_name = "#{dist}-manager"
      define_vbox c, private_ip: '192.168.33.10'
    end
  end
end
