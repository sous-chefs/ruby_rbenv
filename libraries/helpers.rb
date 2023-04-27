#
# Cookbook:: ruby_rbenv
# Library:: Chef::Rbenv::ShellHelpers
#
# Author:: Fletcher Nichol <fnichol@nichol.ca>
#
# Copyright:: 2011-2017, Fletcher Nichol
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

class Chef
  module Rbenv
    module Helpers
      def self.root_path(node, resource_user = nil)
        node.run_state['sous-chefs'] ||= {}
        node.run_state['sous-chefs']['ruby_rbenv'] ||= {}
        node.run_state['sous-chefs']['ruby_rbenv']['root_path'] ||= {}

        if resource_user
          node.run_state['sous-chefs']['ruby_rbenv']['root_path'][resource_user]
        else
          node.run_state['sous-chefs']['ruby_rbenv']['root_path']['system']
        end
      end

      def wrap_shim_cmd(cmd)
        [%(export RBENV_ROOT="#{rbenv_root}"),
         %(export PATH="$RBENV_ROOT/bin:$RBENV_ROOT/shims:$PATH"),
         %(export RBENV_VERSION="#{new_resource.rbenv_version}"),
         %($RBENV_ROOT/shims/#{cmd}),
        ].join(' && ')
      end

      def root_path
        Chef::Rbenv::Helpers.root_path(node, new_resource.user)
      end

      def which_rbenv
        "(#{new_resource.user || 'system'})"
      end

      def binary
        prefix = new_resource.user ? "sudo -u #{new_resource.user} " : ''
        "#{prefix}#{new_resource.root_path}/versions/#{new_resource.rbenv_version}/bin/gem"
      end

      def script_code
        script = []
        script << %(export RBENV_ROOT="#{new_resource.root_path}")
        script << %(export PATH="${RBENV_ROOT}/bin:$PATH")
        script << %{eval "$(rbenv init -)"}
        if new_resource.rbenv_version
          script << %(export RBENV_VERSION="#{new_resource.rbenv_version}")
        end
        script << new_resource.code
        script.join("\n").concat("\n")
      end

      def script_environment
        script_env = { 'RBENV_ROOT' => new_resource.root_path }

        script_env.merge!(new_resource.environment) if new_resource.environment

        if new_resource.path
          script_env['PATH'] = "#{new_resource.path.join(':')}:#{ENV['PATH']}"
        end

        if new_resource.user
          script_env['USER'] = new_resource.user
          script_env['HOME'] = ::File.expand_path("~#{new_resource.user}")
        end

        script_env
      end

      def package_prerequisites
        case node['platform_family']
        when 'rhel', 'fedora', 'amazon'
          %w(git grep tar)
        when 'debian', 'suse', 'arch'
          %w(git grep)
        when 'freebsd'
          %w(git bash)
        else
          %w(git)
        end
      end

      def ruby_installed?
        if Array(new_resource.action).include?(:reinstall)
          return false
        elsif ::File.directory?(::File.join(new_resource.root_path, 'versions', new_resource.version))
          return true
        end

        false
      end

      def verbose
        return '-v' if new_resource.verbose
      end
    end
  end
end
