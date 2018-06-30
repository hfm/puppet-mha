require 'spec_helper'
describe 'mha::manager' do
  context 'with default values for all parameters' do
    it { is_expected.to compile }
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('mha::manager') }

    it { is_expected.to contain_file('/usr/bin/mysql_online_switch').with_ensure('present') }
    it { is_expected.to contain_file('/etc/masterha').with_ensure('directory') }
    it { is_expected.to contain_package('mha4mysql-manager') }
  end

  context 'with absent' do
    let(:params) do
      {
        script_ensure: 'absent',
      }
    end

    it { is_expected.to compile }
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('mha::manager') }

    it { is_expected.to contain_file('/usr/bin/mysql_online_switch').with_ensure('absent') }
  end

  %w[
    perl-Config-Tiny
    perl-Log-Dispatch
    perl-Parallel-ForkManager
    perl-Time-HiRes
  ].each do |perl_pkg|
    it { is_expected.to contain_package(perl_pkg) }
  end
end
