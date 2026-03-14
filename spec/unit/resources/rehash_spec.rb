# frozen_string_literal: true

require 'spec_helper'

describe 'rbenv_rehash' do
  step_into :rbenv_rehash
  platform 'ubuntu', '24.04'

  context 'with system install' do
    recipe do
      rbenv_rehash 'system' do
        root_path '/usr/local/rbenv'
      end
    end

    it { is_expected.to run_rbenv_script('rbenv rehash (system)') }
  end

  context 'with user install' do
    recipe do
      rbenv_rehash 'rehash' do
        user 'vagrant'
        root_path '/home/vagrant/.rbenv'
      end
    end

    it { is_expected.to run_rbenv_script('rbenv rehash (vagrant)') }
  end
end
