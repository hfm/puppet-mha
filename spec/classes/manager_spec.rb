require 'spec_helper'
describe 'mha::manager' do
  context 'with default values for all parameters' do
    let(:facts) { { osfamily: 'redhat', operatingsystem: 'CentOS', operatingsystemmajrelease: '7' } }

    it { should compile }
    it { should compile.with_all_deps }
    it { should contain_class('mha::manager') }
    it { should contain_class('mha::manager::install') }
    it { should contain_class('mha::manager::script') }

    it { should contain_file('/usr/bin/mysql_online_switch').with_ensure('present') }
    it { should contain_file('/etc/masterha').with_ensure('directory') }
    it { should contain_package('mha4mysql-manager') }
  end

  context 'with absent' do
    let(:facts) { { osfamily: 'redhat', operatingsystem: 'CentOS', operatingsystemmajrelease: '7' } }
    let(:params) do
      {
        script_ensure: 'absent'
      }
    end

    it { should compile }
    it { should compile.with_all_deps }
    it { should contain_class('mha::manager') }
    it { should contain_class('mha::manager::install') }
    it { should contain_class('mha::manager::script') }

    it { should contain_file('/usr/bin/mysql_online_switch').with_ensure('absent') }
  end

  5.upto(7) do |version|
    context "with perl packages in CentOS #{version}" do
      let(:facts) { { osfamily: 'redhat', operatingsystem: 'CentOS', operatingsystemmajrelease: version.to_s } }

      case version
      when 5
        %w[
          perl-Config-Tiny
          perl-Log-Dispatch
          perl-Parallel-ForkManager
        ]
      else
        %w[
          perl-Config-Tiny
          perl-Log-Dispatch
          perl-Parallel-ForkManager
          perl-Time-HiRes
        ]
      end.each do |perl_pkg|
        it { should contain_package(perl_pkg) }
      end
    end
  end
end
