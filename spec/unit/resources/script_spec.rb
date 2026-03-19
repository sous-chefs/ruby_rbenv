# frozen_string_literal: true

require 'spec_helper'

describe 'rbenv_script' do
  step_into :rbenv_script
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      rbenv_script 'install bundler' do
        code 'gem install bundler'
        root_path '/usr/local/rbenv'
      end
    end

    it { is_expected.to run_bash('install bundler') }
  end

  context 'with user install' do
    before do
      allow(File).to receive(:expand_path).and_call_original
      allow(File).to receive(:expand_path).with('~vagrant').and_return('/home/vagrant')
    end

    recipe do
      rbenv_script 'install bundler' do
        code 'gem install bundler'
        user 'vagrant'
        root_path '/home/vagrant/.rbenv'
      end
    end

    it { is_expected.to run_bash('install bundler').with(user: 'vagrant') }
  end

  context 'with rbenv_version' do
    recipe do
      rbenv_script 'install bundler' do
        code 'gem install bundler'
        rbenv_version '3.4.9'
        root_path '/usr/local/rbenv'
      end
    end

    it { is_expected.to run_bash('install bundler') }
  end

  context 'with creates guard' do
    recipe do
      rbenv_script 'install bundler' do
        code 'gem install bundler'
        creates '/usr/local/rbenv/shims/bundle'
        root_path '/usr/local/rbenv'
      end
    end

    it { is_expected.to run_bash('install bundler').with(creates: '/usr/local/rbenv/shims/bundle') }
  end
end
