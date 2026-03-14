# frozen_string_literal: true

require 'spec_helper'
require_relative '../libraries/package_deps'

describe Chef::Rbenv::PackageDeps do
  let(:helper_class) do
    Class.new do
      include Chef::Rbenv::PackageDeps

      attr_accessor :node, :new_resource

      def platform?(name)
        node['platform'] == name
      end

      def platform_family?(*families)
        families.include?(node['platform_family'])
      end
    end
  end

  let(:helper) { helper_class.new }
  let(:resource) { double('resource', version: '3.4.9') }

  before do
    helper.new_resource = resource
    helper.node = {
      'platform' => 'ubuntu',
      'platform_family' => 'debian',
      'platform_version' => '24.04',
    }
  end

  describe '#package_deps' do
    context 'on debian family' do
      it 'returns debian build dependencies' do
        expect(helper.package_deps).to eq %w(gcc autoconf bison build-essential libssl-dev libreadline-dev zlib1g-dev libncurses-dev libffi-dev libgdbm-dev make)
      end
    end

    context 'on rhel family' do
      before do
        helper.node = helper.node.merge(
          'platform' => 'almalinux',
          'platform_family' => 'rhel'
        )
      end

      it 'returns rhel build dependencies' do
        expect(helper.package_deps).to eq %w(gcc bzip2 openssl-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel make)
      end
    end

    context 'on fedora' do
      before do
        helper.node = helper.node.merge(
          'platform' => 'fedora',
          'platform_family' => 'fedora'
        )
      end

      it 'returns rhel-style build dependencies' do
        expect(helper.package_deps).to eq %w(gcc bzip2 openssl-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel make)
      end
    end

    context 'on amazon linux' do
      before do
        helper.node = helper.node.merge(
          'platform' => 'amazon',
          'platform_family' => 'amazon'
        )
      end

      it 'returns rhel-style build dependencies' do
        expect(helper.package_deps).to eq %w(gcc bzip2 openssl-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel make)
      end
    end

    context 'on suse family' do
      before do
        helper.node = helper.node.merge(
          'platform' => 'opensuseleap',
          'platform_family' => 'suse'
        )
      end

      it 'returns suse build dependencies' do
        expect(helper.package_deps).to eq %w(gcc make automake gdbm-devel ncurses-devel readline-devel zlib-devel libopenssl-devel bzip2)
      end
    end

    context 'on mac_os_x' do
      before do
        helper.node = helper.node.merge(
          'platform' => 'mac_os_x',
          'platform_family' => 'mac_os_x'
        )
      end

      it 'returns macOS build dependencies' do
        expect(helper.package_deps).to eq %w(openssl makedepend pkg-config libffi)
      end
    end
  end

  describe '#jruby_package_deps' do
    context 'on debian family' do
      it 'returns debian jruby dependencies' do
        expect(helper.jruby_package_deps).to eq %w(make g++)
      end
    end

    context 'on rhel family' do
      before do
        helper.node = helper.node.merge(
          'platform' => 'almalinux',
          'platform_family' => 'rhel'
        )
      end

      it 'returns rhel jruby dependencies' do
        expect(helper.jruby_package_deps).to eq %w(make gcc-c++)
      end
    end

    context 'on freebsd' do
      before do
        helper.node = helper.node.merge(
          'platform' => 'freebsd',
          'platform_family' => 'freebsd'
        )
      end

      it 'returns freebsd jruby dependencies' do
        expect(helper.jruby_package_deps).to be_an(Array)
        expect(helper.jruby_package_deps).to include('bash')
      end
    end
  end
end
