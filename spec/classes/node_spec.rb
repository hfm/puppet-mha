require 'spec_helper'

def supported_os
  {
    'redhat' => [5, 6]
  }
end

describe 'mha::node' do
  supported_os.each do |os, releases|
    releases.each do |release|
      let(:facts) do
        {
          osfamily: os,
          operatingsystemmajrelease: release,
        }
      end

      let(:params) do
        { :manager => 'manager.sample.com' }
      end

      it { should compile }
      it { should compile.with_all_deps }
      it { should contain_class('mha::node') }
    end
  end
end
