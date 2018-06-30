require 'spec_helper_acceptance'

describe 'mha::manager class' do
  let(:manifest) do
    <<-EOS
      case $::operatingsystemmajrelease {
        '6': { include '::mha::manager' }
        '7': {
          class { '::mha::manager':
            version      => '0.57-0',
            node_version => '0.57-0',
          }
        }
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

  describe file('/usr/bin/mysql_online_switch') do
    it { is_expected.to be_file }
    it { is_expected.to be_mode 755 }
  end

  %w[
    perl-Config-Tiny
    perl-Log-Dispatch
    perl-Parallel-ForkManager
    perl-Time-HiRes
  ].each do |perl_pkg|
    describe package(perl_pkg) do
      it { is_expected.to be_installed }
    end
  end

  describe package('mha4mysql-manager') do
    it { is_expected.to be_installed }
  end

  describe file('/etc/masterha') do
    it { is_expected.to be_directory }
    it { is_expected.to be_owned_by('root') }
    it { is_expected.to be_grouped_into('root') }
    it { is_expected.to be_mode 755 }
  end
end
