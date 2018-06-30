require 'spec_helper'

describe 'mha::ssh_private_key' do
  let(:title) { 'mha::node' }

  let(:params) do
    {
      user: 'root',
      path: '/root/.ssh/id_mha',
      content: '',
    }
  end

  context 'with default values for all parameters' do
    it { is_expected.to compile }
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_file('/root/.ssh/id_mha') }
  end
end
