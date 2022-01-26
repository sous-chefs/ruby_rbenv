#
# Cookbook:: ruby_rbenv
# Resource:: gem
#
# Author:: Fletcher Nichol <fnichol@nichol.ca>
# Author:: Dan Webb <dan.webb.damacus.io>
#
# Copyright:: 2011-2018, Fletcher Nichol
# Copyright:: 2017-2021, Dan Webb
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

provides :rbenv_gem
unified_mode true
use '_partial/_common'
# Standard Gem Package Options
# https://docs.chef.io/resource_gem_package.html#properties
property :clear_sources,
        [true, false],
        description: 'Clear the gem sources.'

property :include_default_source,
        [true, false],
        default: true,
        description: 'Set to false to not include Chef::Config[:rubygems_url] in the sources.'

property :ignore_failure,
        [true, false],
        default: false,
        description: 'Continue running a recipe if a resource fails for any reason.'

property :options,
        [String, Hash],
        description: 'Options to pass to the gem command.'

property :package_name,
        [String, Array],
        name_property: true,
        description: 'The Gem package name to install.'

property :source,
        [String, Array],
        description: 'Source URL/location for gem.'

property :timeout,
        Integer,
        default: 300,
        description: 'Timeout in seconds to wait for Gem installation.'

property :version,
        String,
        description: 'Gem version to install.'

property :response_file,
        String,
        description: 'Response file to reconfigure a gem.'

property :rbenv_version,
        String,
        required: true,
        description: 'Which rbenv version to install the Gem to.'

default_action :install

action :install do
  gem_package new_resource.package_name do
    clear_sources new_resource.clear_sources if new_resource.clear_sources
    ignore_failure new_resource.ignore_failure if new_resource.ignore_failure
    include_default_source new_resource.include_default_source
    gem_binary binary
    options new_resource.options if new_resource.options
    package_name new_resource.package_name if new_resource.package_name
    source new_resource.source if new_resource.source
    timeout new_resource.timeout if new_resource.timeout
    version new_resource.version if new_resource.version
    action :install
  end
end

action :purge do
  gem_package new_resource.package_name do
    clear_sources new_resource.clear_sources if new_resource.clear_sources
    ignore_failure new_resource.ignore_failure if new_resource.ignore_failure
    include_default_source new_resource.include_default_source
    gem_binary binary
    options new_resource.options if new_resource.options
    package_name new_resource.package_name if new_resource.package_name
    source new_resource.source if new_resource.source
    timeout new_resource.timeout if new_resource.timeout
    version new_resource.version if new_resource.version
    action :purge
  end
end

action :reconfig do
  gem_package new_resource.package_name do
    clear_sources new_resource.clear_sources if new_resource.clear_sources
    ignore_failure new_resource.ignore_failure if new_resource.ignore_failure
    include_default_source new_resource.include_default_source
    gem_binary binary
    options new_resource.options if new_resource.options
    package_name new_resource.package_name if new_resource.package_name
    source new_resource.source if new_resource.source
    timeout new_resource.timeout if new_resource.timeout
    version new_resource.version if new_resource.version
    response if new_resource.response_file
    action :reconfig
  end
end

action :remove do
  gem_package new_resource.package_name do
    clear_sources new_resource.clear_sources if new_resource.clear_sources
    ignore_failure new_resource.ignore_failure if new_resource.ignore_failure
    include_default_source new_resource.include_default_source
    gem_binary binary
    options new_resource.options if new_resource.options
    package_name new_resource.package_name if new_resource.package_name
    source new_resource.source if new_resource.source
    timeout new_resource.timeout if new_resource.timeout
    version new_resource.version if new_resource.version
    action :remove
  end
end

action :upgrade do
  gem_package new_resource.package_name do
    clear_sources new_resource.clear_sources if new_resource.clear_sources
    ignore_failure new_resource.ignore_failure if new_resource.ignore_failure
    include_default_source new_resource.include_default_source
    gem_binary binary
    options new_resource.options if new_resource.options
    package_name new_resource.package_name if new_resource.package_name
    source new_resource.source if new_resource.source
    timeout new_resource.timeout if new_resource.timeout
    version new_resource.version if new_resource.version
    action :upgrade
  end
end

action_class do
  include Chef::Rbenv::Helpers
end
