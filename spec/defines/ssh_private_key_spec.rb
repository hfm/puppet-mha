require 'spec_helper'

describe 'mha::ssh_private_key' do
  let(:title) { 'mha::node' }

  let(:params) do
    {
      path: '/root/.ssh/id_mha',
      content: '',
    }
  end

  context 'with default values for all parameters' do
    it { should compile }
    it { should compile.with_all_deps }

    it { should contain_file('/root/.ssh').with_ensure('directory') }
    it { should contain_file('/root/.ssh/id_mha') }
  end
end
