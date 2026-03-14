# frozen_string_literal: true

require 'spec_helper'

describe 'rbenv_user_install' do
  step_into :rbenv_user_install
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      rbenv_user_install 'vagrant' do
        home_dir '/home/vagrant'
      end
    end

    it { is_expected.to install_package(%w(git grep)) }
    it { is_expected.to sync_git('/home/vagrant/.rbenv') }

    %w(plugins shims versions).each do |dir|
      it { is_expected.to create_directory("/home/vagrant/.rbenv/#{dir}").with(owner: 'vagrant', group: 'vagrant', mode: '0755') }
    end

    it { is_expected.to nothing_ruby_block('Add rbenv to PATH') }
    it { is_expected.to nothing_bash('Initialize user vagrant rbenv') }
  end

  context 'with custom group' do
    recipe do
      rbenv_user_install 'vagrant' do
        home_dir '/home/vagrant'
        group 'custom-group'
      end
    end

    it { is_expected.to sync_git('/home/vagrant/.rbenv').with(user: 'vagrant', group: 'custom-group') }

    %w(plugins shims versions).each do |dir|
      it { is_expected.to create_directory("/home/vagrant/.rbenv/#{dir}").with(owner: 'vagrant', group: 'custom-group') }
    end
  end

  context 'with update_rbenv false' do
    recipe do
      rbenv_user_install 'vagrant' do
        home_dir '/home/vagrant'
        update_rbenv false
      end
    end

    it { is_expected.to checkout_git('/home/vagrant/.rbenv') }
  end

  context 'on almalinux' do
    platform 'almalinux', '9'

    recipe do
      rbenv_user_install 'vagrant' do
        home_dir '/home/vagrant'
      end
    end

    it { is_expected.to install_package(%w(git grep tar)) }
  end
end
