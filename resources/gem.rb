#
# Cookbook:: ruby_rbenv
# Resource:: gem
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

property :package_name, String, name_property: true
property :rbenv_version, String, default: 'global'
property :version, String
property :response_file, String
property :source, String
property :options, [String, Hash]
property :gem_binary, String
property :user, String
property :root_path, String
property :clear_sources, [true, false]
property :timeout, Integer, default: 300
property :include_default_source, [true, false]

default_action :install

provides :rbenv_gem

action :install do
end

action :upgrade do
end

action :remove do
end

action :purge do
end

action_class do
  include Chef::Rbenv::Mixin::ResourceString
  include Chef::Provider::Package::RbenvRubygems
end
