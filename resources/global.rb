#
# Cookbook:: ruby_rbenv
# Resource:: global
#
# Author:: Fletcher Nichol <fnichol@nichol.ca>
# Author:: Dan Webb <dan.webb.damacus.io>
#
# Copyright:: 2011-2018, Fletcher Nichol
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

# Check for the user or system global verison
# If we pass in a user check that users global

provides :rbenv_global
unified_mode true

property :rbenv_version, String, name_property: true
property :user,          String
property :root_path,     String, default: lazy { Chef::Rbenv::Helpers.root_path(node, user) }

# This sets the Global rbenv version
# e.g. "rbenv global" should return the version we set

action :create do
  rbenv_script "globals #{which_rbenv}" do
    code "rbenv global #{new_resource.rbenv_version}"
    user new_resource.user if new_resource.user
    root_path new_resource.root_path
    action :run
    not_if { current_global_version_correct? }
  end
end

action_class do
  include Chef::Rbenv::Helpers

  def current_global_version_correct?
    current_global_version == new_resource.rbenv_version
  end

  def current_global_version
    version_file = ::File.join(new_resource.root_path, 'version')

    ::File.exist?(version_file) && ::IO.read(version_file).chomp
  end
end
