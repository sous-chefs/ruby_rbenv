# frozen_string_literal: true

require 'spec_helper'
require_relative '../libraries/helpers'

describe Chef::Rbenv::Helpers do
  let(:helper_class) do
    Class.new do
      include Chef::Rbenv::Helpers

      attr_accessor :node

      def platform_family?(family)
        node['platform_family'] == family
      end

      def platform?(name)
        node['platform'] == name
      end
    end
  end

  let(:helper) { helper_class.new }

  before do
    helper.node = {
      'platform' => 'ubuntu',
      'platform_family' => 'debian',
      'platform_version' => '24.04',
    }
  end

  describe '#package_prerequisites' do
    context 'on debian family' do
      it 'returns git and grep' do
        expect(helper.package_prerequisites).to eq %w(git grep)
      end
    end

    context 'on rhel family' do
      before do
        helper.node = helper.node.merge(
          'platform' => 'almalinux',
          'platform_family' => 'rhel',
          'platform_version' => '9'
        )
      end

      it 'returns git, grep, and tar' do
        expect(helper.package_prerequisites).to eq %w(git grep tar)
      end
    end

    context 'on fedora' do
      before do
        helper.node = helper.node.merge(
          'platform' => 'fedora',
          'platform_family' => 'fedora',
          'platform_version' => '40'
        )
      end

      it 'returns git, grep, and tar' do
        expect(helper.package_prerequisites).to eq %w(git grep tar)
      end
    end

    context 'on suse family' do
      before do
        helper.node = helper.node.merge(
          'platform' => 'opensuseleap',
          'platform_family' => 'suse',
          'platform_version' => '15'
        )
      end

      it 'returns git and grep' do
        expect(helper.package_prerequisites).to eq %w(git grep)
      end
    end

    context 'on freebsd' do
      before do
        helper.node = helper.node.merge(
          'platform' => 'freebsd',
          'platform_family' => 'freebsd',
          'platform_version' => '14'
        )
      end

      it 'returns git and bash' do
        expect(helper.package_prerequisites).to eq %w(git bash)
      end
    end
  end

  describe '.root_path' do
    let(:node) do
      {
        'run_state' => {},
      }
    end

    before do
      # Simulate run_state
      allow(helper).to receive(:node).and_return(node)
      node.instance_variable_set(:@run_state, {})
      node.define_singleton_method(:run_state) { @run_state }
    end

    it 'returns system path when no user specified' do
      node.run_state['sous-chefs'] = {
        'ruby_rbenv' => {
          'root_path' => { 'system' => '/usr/local/rbenv' },
        },
      }

      expect(Chef::Rbenv::Helpers.root_path(node)).to eq '/usr/local/rbenv'
    end

    it 'returns user path when user specified' do
      node.run_state['sous-chefs'] = {
        'ruby_rbenv' => {
          'root_path' => { 'vagrant' => '/home/vagrant/.rbenv' },
        },
      }

      expect(Chef::Rbenv::Helpers.root_path(node, 'vagrant')).to eq '/home/vagrant/.rbenv'
    end

    it 'initializes run_state when empty' do
      expect(Chef::Rbenv::Helpers.root_path(node)).to be_nil
      expect(node.run_state['sous-chefs']['ruby_rbenv']['root_path']).to eq({})
    end
  end
end
