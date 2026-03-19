# frozen_string_literal: true

require 'spec_helper'

describe 'rbenv_gem' do
  step_into :rbenv_gem
  platform 'ubuntu', '24.04'

  context 'action :install with default properties' do
    recipe do
      rbenv_gem 'bundler' do
        rbenv_version '3.4.9'
        root_path '/usr/local/rbenv'
      end
    end

    it { is_expected.to install_gem_package('bundler') }
  end

  context 'action :install with version' do
    recipe do
      rbenv_gem 'mail' do
        version '2.8.1'
        rbenv_version '3.4.9'
        root_path '/usr/local/rbenv'
      end
    end

    it { is_expected.to install_gem_package('mail').with(version: '2.8.1') }
  end

  context 'action :remove' do
    recipe do
      rbenv_gem 'mail' do
        rbenv_version '3.4.9'
        root_path '/usr/local/rbenv'
        action :remove
      end
    end

    it { is_expected.to remove_gem_package('mail') }
  end

  context 'action :upgrade' do
    recipe do
      rbenv_gem 'bundler' do
        rbenv_version '3.4.9'
        root_path '/usr/local/rbenv'
        action :upgrade
      end
    end

    it { is_expected.to upgrade_gem_package('bundler') }
  end

  context 'with user install' do
    recipe do
      rbenv_gem 'bundler' do
        user 'vagrant'
        rbenv_version '3.4.9'
        root_path '/home/vagrant/.rbenv'
      end
    end

    it { is_expected.to install_gem_package('bundler') }
  end
end
