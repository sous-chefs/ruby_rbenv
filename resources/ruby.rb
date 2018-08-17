#
# Cookbook:: ruby_rbenv
# Resource:: ruby
#
# Author:: Fletcher Nichol <fnichol@nichol.ca>
# Author:: Dan Webb <dan.webb@damacus.io>
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
provides :rbenv_ruby

property :version,            String, name_property: true
property :version_file,       String
property :user,               String
property :environment,        Hash
property :rbenv_action,       String, default: 'install'
property :verbose,            [true, false], default: false
property :ruby_build_git_url, String, default: 'https://github.com/rbenv/ruby-build.git'

action :install do
  Chef::Log.fatal('Rubinius not supported by this cookbook') if new_resource.version =~ /rbx/

  install_start = Time.now

  Chef::Log.info("Building Ruby #{new_resource.version}, this could take a while...")

  rbenv_plugin 'ruby-build' do
    git_url new_resource.ruby_build_git_url
    user new_resource.user if new_resource.user
  end

  install_ruby_dependencies

  # TODO: ?
  # patch_command = "--patch < <(curl -sSL #{new_resource.patch_url})" if new_resource.patch_url
  # patch_command = "--patch < #{new_resource.patch_file}" if new_resource.patch_file
  command = %(rbenv #{new_resource.rbenv_action} #{new_resource.version})
  command << ' --verbose' if new_resource.verbose

  # begin

  rbenv_script "#{command} #{which_rbenv}" do
    code command
    user new_resource.user if new_resource.user
    environment new_resource.environment if new_resource.environment
    action :run
    live_stream true if new_resource.verbose
  end unless ruby_installed?

  Chef::Log.info("#{new_resource} build time was #{(Time.now - install_start) / 60.0} minutes")
end

action :reinstall do
end

action_class do
  include Chef::Rbenv::Helpers
  include Chef::Rbenv::PackageDeps
end
