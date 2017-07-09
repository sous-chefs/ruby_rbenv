#
# Cookbook:: ruby_rbenv
# Resource:: plugin
#
# Author:: Dan Webb <dan.webb@damacus.io>
#
# Copyright:: 2017, Dan Webb
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
provides :rbenv_plugin

property :git_url, String
property :git_ref, String, default: 'master'
property :user, String
property :root_path, String, default: 'root'

# https://github.com/rbenv/rbenv/wiki/Plugins
# The most useful one here is ruby-build

action_class do
  include Chef::Rbenv::ScriptHelpers
end

action :install do
  directory ::File.join(new_resource.root_path, 'plugins') do
    owner new_resource.user
    mode '0755'
    action :create
  end

  plugin_path = ::File.join(new_resource.rbenv_root, 'plugins', new_resource.name)

  git "Install #{new_resource.name} plugin" do
    destination plugin_path
    repository new_resource.git_url
    reference new_resource.git_ref
    user new_resource.user if new_resource.user
    action :sync
  end
end
