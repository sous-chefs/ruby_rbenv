#
# Cookbook Name:: ruby_rbenv
# Provider:: Chef::Provider::Package::RbenvRubygems
#
# Author:: Fletcher Nichol <fnichol@nichol.ca>
#
# Copyright 2011, Fletcher Nichol
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
require 'etc'

class Chef
  module Rbenv
    module Mixin
      module ShellOut
        # stub to satisfy RbenvRubygems (library load order not guarenteed)
      end
    end

    module ScriptHelpers
      # stub to satisfy RbenvRubygems (library load order not guarenteed)
    end
  end

  class Provider
    class Package
      class RbenvRubygems < Chef::Provider::Package::Rubygems
        class RbenvGemEnvironment < AlternateGemEnvironment
          attr_reader :rbenv_version, :rbenv_user

          include Chef::Rbenv::Mixin::ShellOut

          def initialize(gem_binary_location, rbenv_version, rbenv_user = nil)
            super(gem_binary_location)
            @rbenv_version = rbenv_version
            @rbenv_user = rbenv_user
          end
        end

        attr_reader :rbenv_user

        include Chef::Rbenv::Mixin::ShellOut
        include Chef::Rbenv::ScriptHelpers

        def initialize(new_resource, run_context = nil)
          super
          normalize_version
          @new_resource.gem_binary(wrap_shim_cmd('gem'))
          @rbenv_user = new_resource.respond_to?('user') ? new_resource.user : nil
          @gem_env = RbenvGemEnvironment.new(
            gem_binary_path, new_resource.rbenv_version, rbenv_user)
        end

        def install_package(name, version)
          run_as_user(rbenv_user) { super }
          rehash
          true
        end

        def remove_package(name, version)
          run_as_user(rbenv_user) { super }
          rehash
          true
        end

        private

        # converts "global" to the current global ruby version
        def normalize_version
          @new_resource.rbenv_version(current_global_version) if @new_resource.rbenv_version == 'global'
        end

        def rehash
          e = ::Chef::Resource::RubyRbenvRehash.new(new_resource.name, @run_context)
          e.root_path rbenv_root
          e.user rbenv_user if rbenv_user
          e.action :nothing
          e.run_action(:run)
        end
      end
    end
  end
end
