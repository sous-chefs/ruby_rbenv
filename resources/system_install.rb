#
# Cookbook:: ruby_rbenv
# Resource:: system_install
#
# Author:: Dan Webb <dan.webb@damacus.io>
#
# Copyright:: 2017-2018, Dan Webb
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

# Install rbenv to a system wide location
provides :rbenv_system_install
unified_mode true

property :git_url,       String, default: 'https://github.com/rbenv/rbenv.git'
property :git_ref,       String, default: 'main'
property :global_prefix, String, default: '/usr/local/rbenv'
property :update_rbenv,  [true, false], default: true

action :install do
  node.run_state['sous-chefs'] ||= {}
  node.run_state['sous-chefs']['ruby_rbenv'] ||= {}
  node.run_state['sous-chefs']['ruby_rbenv']['root_path'] ||= {}

  node.run_state['sous-chefs']['ruby_rbenv']['root_path']['system'] = new_resource.global_prefix

  package package_prerequisites

  directory '/etc/profile.d' do
    owner 'root'
    mode '0755'
  end

  template '/etc/profile.d/rbenv.sh' do
    cookbook 'ruby_rbenv'
    source 'rbenv.sh.erb'
    owner 'root'
    mode '0755'
    variables(global_prefix: new_resource.global_prefix)
  end

  git new_resource.global_prefix do
    repository new_resource.git_url
    reference new_resource.git_ref
    action :checkout if new_resource.update_rbenv == false
    notifies :run, 'ruby_block[Add rbenv to PATH]', :immediately
    notifies :run, 'bash[Initialize system rbenv]', :immediately
  end

  directory "#{new_resource.global_prefix}/plugins" do
    owner 'root'
    mode '0755'
  end

  # Initialize rbenv
  ruby_block 'Add rbenv to PATH' do
    block do
      ENV['PATH'] = "#{new_resource.global_prefix}/shims:#{new_resource.global_prefix}/bin:#{ENV['PATH']}"
    end
    action :nothing
  end

  bash 'Initialize system rbenv' do
    code %(PATH="#{new_resource.global_prefix}/bin:$PATH" rbenv init -)
    environment('RBENV_ROOT' => new_resource.global_prefix)
    action :nothing
  end
end

action_class do
  include Chef::Rbenv::Helpers
end
