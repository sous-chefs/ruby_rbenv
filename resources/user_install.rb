#
# Cookbook:: ruby_rbenv
# Resource:: user_install
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

# Install rbenv to a user location
provides :rbenv_user_install

property :git_url,      String, default: 'https://github.com/rbenv/rbenv.git'
property :git_ref,      String, default: 'master'
property :user,         String, name_property: true
property :group,        String, default: lazy { user }
property :home_dir,     String, default: lazy { ::File.expand_path("~#{user}") }
property :user_prefix,  String, default: lazy { ::File.join(home_dir, '.rbenv') }
property :update_rbenv, [true, false], default: true

action :install do
  package package_prerequisites

  node.run_state['root_path'] ||= {}
  node.run_state['root_path'][new_resource.user] ||= new_resource.user_prefix

  system_prefix = node.run_state['root_path']['system']

  template '/etc/profile.d/rbenv.sh' do
    cookbook 'ruby_rbenv'
    source 'rbenv.sh.erb'
    variables(global_prefix: system_prefix) if system_prefix
    owner 'root'
    mode '0755'
  end

  git new_resource.user_prefix do
    repository new_resource.git_url
    reference new_resource.git_ref
    action :checkout if new_resource.update_rbenv == false
    user new_resource.user
    group new_resource.group
    notifies :run, 'ruby_block[Add rbenv to PATH]', :immediately
  end

  %w(plugins shims versions).each do |d|
    directory "#{new_resource.user_prefix}/#{d}" do
      owner new_resource.user
      group new_resource.group
      mode '0755'
    end
  end

  # Initialize rbenv
  ruby_block 'Add rbenv to PATH' do
    block do
      ENV['PATH'] = "#{new_resource.user_prefix}/shims:#{new_resource.user_prefix}/bin:#{ENV['PATH']}"
    end
    action :nothing
  end

  bash 'Initialize user #{new_resource.user} rbenv' do
    code %(PATH="#{new_resource.user_prefix}/bin:$PATH" rbenv init -)
    environment('RBENV_ROOT' => new_resource.user_prefix)
    action :nothing
    subscribes :run, "git[#{new_resource.user_prefix}]", :immediately
    # Subscribe because it's easier to find the resource ;)
  end
end

action_class do
  include Chef::Rbenv::Helpers
end
