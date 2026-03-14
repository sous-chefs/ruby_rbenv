# frozen_string_literal: true

require 'spec_helper'

describe 'rbenv_system_install' do
  step_into :rbenv_system_install
  platform 'ubuntu', '24.04'

  context 'with default properties (update_rbenv defaults to true)' do
    recipe do
      rbenv_system_install 'system'
    end

    it { is_expected.to install_package(%w(git grep)) }
    it { is_expected.to create_directory('/etc/profile.d').with(owner: 'root', mode: '0755') }
    it { is_expected.to create_template('/etc/profile.d/rbenv.sh').with(owner: 'root', mode: '0755') }
    it { is_expected.to sync_git('/usr/local/rbenv') }
    it { is_expected.to create_directory('/usr/local/rbenv/plugins').with(owner: 'root', mode: '0755') }
    it { is_expected.to nothing_ruby_block('Add rbenv to PATH') }
    it { is_expected.to nothing_bash('Initialize system rbenv') }
  end

  context 'with custom global_prefix' do
    recipe do
      rbenv_system_install 'system' do
        global_prefix '/opt/rbenv'
      end
    end

    it { is_expected.to sync_git('/opt/rbenv') }
    it { is_expected.to create_directory('/opt/rbenv/plugins') }
  end

  context 'with update_rbenv false' do
    recipe do
      rbenv_system_install 'system' do
        update_rbenv false
      end
    end

    it { is_expected.to checkout_git('/usr/local/rbenv') }
  end

  context 'on almalinux' do
    platform 'almalinux', '9'

    recipe do
      rbenv_system_install 'system'
    end

    it { is_expected.to install_package(%w(git grep tar)) }
  end
end
