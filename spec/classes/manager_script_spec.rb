require 'spec_helper'

describe 'mha::manager::script' do
  context 'with default values for all parameters' do
    it { should compile }
    it { should compile.with_all_deps }
    it { should contain_class('mha::manager::script') }
    it { should contain_file('/usr/bin/mysql_online_switch') }
  end

  context 'with absent' do
    let(:params) {{ ensure: 'absent' }}

    it { should contain_file('/usr/bin/mysql_online_switch').with_ensure('absent') }
  end
end
