require 'spec_helper_acceptance'

describe 'mha::node class' do
  let(:manifest) {
    <<-EOS
      include '::mha::manager'
    EOS
  }

  it 'should work without errors' do
    result = apply_manifest(manifest, :acceptable_exit_codes => [0, 2], :catch_failures => true)
    expect(result.exit_code).not_to eq 4
    expect(result.exit_code).not_to eq 6
  end

  it 'should run a second time without changes' do
    result = apply_manifest(manifest)
    expect(result.exit_code).to eq 0
  end

  describe file('/usr/bin/mysql_online_switch') do
    it { should be_file }
    it { should be_mode 755 }
  end

  perl_pkgs = case os[:release].to_i
              when 5
                [
                  'perl-Config-Tiny',
                  'perl-Log-Dispatch',
                  'perl-Parallel-ForkManager'
                ]
              when 6
                [
                  'perl-Config-Tiny',
                  'perl-Log-Dispatch',
                  'perl-Parallel-ForkManager',
                  'perl-Time-HiRes',
                ]
              end

  perl_pkgs.each do |perl_pkg|
    describe package(perl_pkg) do
      it { should be_installed }
    end
  end

  describe package('mha4mysql-manager') do
    it { should be_installed }
  end
end
