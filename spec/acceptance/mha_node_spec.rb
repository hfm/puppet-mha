require 'spec_helper_acceptance'

describe 'mha::node class' do
  let(:manifest) do
    <<-EOS
      class { '::mysql::server':
        root_password           => 'admin',
        remove_default_accounts => true,
        before                  => Class['mha::node'],
      }

      package { 'cronie':
        ensure => installed,
        before => Service['crond'],
      }

      service { 'crond':
        ensure => running,
        enable => true,
        before => Class['::mha::node'],
      }

      class { '::mha::node':
        manager       => 'mha-manager.example.com',
        user          => 'mha',
        password      => 'admin',
        repl_user     => 'repl',
        repl_password => 'repl',
      }
    EOS
  end

  it 'works without errors' do
    result = apply_manifest(manifest, catch_failures: true)
    expect(result.exit_code).to eq 2
  end

  it 'runs a second time without changes' do
    result = apply_manifest(manifest)
    expect(result.exit_code).to eq 0
  end

  describe package('perl-DBD-MySQL') do
    it { is_expected.to be_installed }
  end

  describe package('mha4mysql-node') do
    it { is_expected.to be_installed }
  end

  describe file('/var/log/masterha') do
    it { is_expected.to be_directory }
    it { is_expected.to be_owned_by('root') }
    it { is_expected.to be_grouped_into('root') }
    it { is_expected.to be_mode 755 }
  end

  entry = '10 2-23/6 * * * sleep $(($RANDOM\%60)) && /usr/bin/purge_relay_logs --host localhost --user=mha --password=admin --disable_relay_log_purge >> /var/log/masterha/purge_relay_logs.log 2>&1'
  describe cron('purge relay logs for MHA') do
    it { is_expected.to have_entry(entry).with_user('root') }
  end
end
