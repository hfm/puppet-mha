require 'spec_helper'
describe 'mha::node' do
  context 'with default values for all parameters' do
    let(:params) do
      {
        manager: 'manager.example.com',
      }
    end

    it { should compile }
    it { should compile.with_all_deps }
    it { should contain_class('mha::node') }
    it { should contain_class('mha::node::install') }
    it { should contain_class('mha::node::grants') }
    it { should contain_class('mha::node::purge_relay_logs') }

    it { should contain_package('perl-DBD-MySQL') }
    it { should contain_package('mha4mysql-node') }
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
