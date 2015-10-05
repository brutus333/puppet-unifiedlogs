require 'spec_helper'

describe 'unifiedlogs' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "unifiedlogs class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('unifiedlogs::params') }
          it { is_expected.to contain_class('unifiedlogs::install').that_comes_before('unifiedlogs::config') }
          it { is_expected.to contain_class('unifiedlogs::config') }
          it { is_expected.to contain_class('unifiedlogs::service').that_subscribes_to('unifiedlogs::config') }

          it { is_expected.to contain_service('unifiedlogs') }
          it { is_expected.to contain_package('unifiedlogs').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'unifiedlogs class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('unifiedlogs') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
