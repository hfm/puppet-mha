require 'spec_helper'
describe 'mha::node' do
  context 'with default values for all parameters' do
    let(:params) do
      {
        manager: 'manager.example.com',
      }
    end

    it { is_expected.to compile }
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('mha::node') }
    it { is_expected.to contain_class('mha::node::install') }
    it { is_expected.to contain_class('mha::node::grants') }
    it { is_expected.to contain_class('mha::node::purge_relay_logs') }

    it { is_expected.to contain_package('perl-DBD-MySQL') }
    it { is_expected.to contain_package('mha4mysql-node') }
    it { is_expected.to contain_file('/var/log/masterha').with_ensure('directory') }
  end

  # context 'with absent' do
  #   let(:facts) {{ :operatingsystemmajrelease => '7' }}
  #   let(:params) do
  #     {
  #       script_ensure: 'absent',
  #     }
  #   end
  #
  #   it { should compile }
  #   it { should compile.with_all_deps }
  #   it { should contain_class('mha::node') }
  #   it { should contain_class('mha::node::install') }
  #
  #   it { should contain_file('/usr/bin/mysql_online_switch').with_ensure('absent') }
  # end
end
