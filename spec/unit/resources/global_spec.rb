# frozen_string_literal: true

require 'spec_helper'

describe 'rbenv_global' do
  step_into :rbenv_global
  platform 'ubuntu', '24.04'

  context 'with system install' do
    recipe do
      rbenv_global '3.4.9' do
        root_path '/usr/local/rbenv'
      end
    end

    it { is_expected.to run_rbenv_script('globals (system)') }
  end

  context 'with user install' do
    recipe do
      rbenv_global '3.4.9' do
        user 'vagrant'
        root_path '/home/vagrant/.rbenv'
      end
    end

    it { is_expected.to run_rbenv_script('globals (vagrant)') }
  end
end
