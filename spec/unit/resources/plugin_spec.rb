# frozen_string_literal: true

require 'spec_helper'

describe 'rbenv_plugin' do
  step_into :rbenv_plugin
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      rbenv_plugin 'ruby-build' do
        git_url 'https://github.com/rbenv/ruby-build.git'
        root_path '/usr/local/rbenv'
      end
    end

    it { is_expected.to sync_git('Install ruby-build plugin') }
  end

  context 'with custom git_ref' do
    recipe do
      rbenv_plugin 'ruby-build' do
        git_url 'https://github.com/rbenv/ruby-build.git'
        git_ref 'v20240119'
        root_path '/usr/local/rbenv'
      end
    end

    it { is_expected.to sync_git('Install ruby-build plugin').with(reference: 'v20240119') }
  end

  context 'with user install' do
    recipe do
      rbenv_plugin 'ruby-build' do
        git_url 'https://github.com/rbenv/ruby-build.git'
        user 'vagrant'
        root_path '/home/vagrant/.rbenv'
      end
    end

    it { is_expected.to sync_git('Install ruby-build plugin').with(user: 'vagrant') }
  end
end
