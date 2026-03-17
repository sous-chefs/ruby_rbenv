# frozen_string_literal: true

require 'spec_helper'

describe 'rbenv_ruby' do
  step_into :rbenv_ruby
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      rbenv_ruby '3.4.9' do
        root_path '/usr/local/rbenv'
      end
    end

    it { is_expected.to install_rbenv_plugin('ruby-build') }
    it { is_expected.to run_rbenv_script('rbenv install 3.4.9 (system)') }
  end

  context 'with verbose output' do
    recipe do
      rbenv_ruby '3.4.9' do
        verbose true
        root_path '/usr/local/rbenv'
      end
    end

    it { is_expected.to run_rbenv_script('rbenv install 3.4.9 --verbose (system)') }
  end

  context 'with user install' do
    recipe do
      rbenv_ruby '3.4.9' do
        user 'vagrant'
        root_path '/home/vagrant/.rbenv'
      end
    end

    it { is_expected.to install_rbenv_plugin('ruby-build') }
    it { is_expected.to run_rbenv_script('rbenv install 3.4.9 (vagrant)') }
  end

  context 'with uninstall action' do
    recipe do
      rbenv_ruby '3.3.10' do
        rbenv_action 'uninstall'
        root_path '/usr/local/rbenv'
      end
    end

    before do
      allow(::File).to receive(:directory?).and_call_original
      allow(::File).to receive(:directory?).with('/usr/local/rbenv/versions/3.3.10').and_return(true)
    end

    it { is_expected.to run_rbenv_script('rbenv uninstall -f 3.3.10 (system)') }
  end
end
