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
property :verbose,            [TrueClass, FalseClass], default: false
property :ruby_build_git_url, String, default: 'https://github.com/rbenv/ruby-build.git'
property :root_path,          String, default: lazy { Chef::Rbenv::Helpers.root_path(node, user) }

action :install do
  Chef::Log.fatal('Rubinius not supported by this cookbook') if new_resource.version =~ /rbx/

  install_start = Time.now

  Chef::Log.info("Building Ruby #{new_resource.version}, this could take a while...")

  rbenv_plugin 'ruby-build' do
    git_url new_resource.ruby_build_git_url
    user new_resource.user if new_resource.user
    root_path new_resource.root_path
  end

  install_ruby_dependencies

  # TODO: ?
  # patch_command = "--patch < <(curl -sSL #{new_resource.patch_url})" if new_resource.patch_url
  # patch_command = "--patch < #{new_resource.patch_file}" if new_resource.patch_file
  command = %(rbenv #{new_resource.rbenv_action})
  # From `rbenv help uninstall`:
  # -f  Attempt to remove the specified version without prompting
  #     for confirmation. If the version does not exist, do not
  #     display an error message.
  command << ' -f' if new_resource.rbenv_action == 'uninstall'
  command << " #{new_resource.version}"
  command << ' --verbose' if new_resource.verbose

  rbenv_script "#{command} #{which_rbenv}" do
    code command
    user new_resource.user if new_resource.user
    root_path new_resource.root_path
    environment new_resource.environment if new_resource.environment
    action :run
    live_stream true if new_resource.verbose
    not_if { ruby_installed? && new_resource.rbenv_action != 'uninstall' }
  end

  log_message = new_resource.to_s
  log_message << if new_resource.rbenv_action == 'uninstall'
                   ' uninstalled'
                 else
                   " build time was #{(Time.now - install_start) / 60.0} minutes"
                 end
  Chef::Log.info(log_message)

  # TODO: If there is no more Ruby installed on the system, the `version` file
  # of rbenv still contains a version number which results in a warning. See
  # this issue and comment for more details:
  # https://github.com/rbenv/rbenv/pull/848#issuecomment-413857386
end

action_class do
  include Chef::Rbenv::Helpers
  include Chef::Rbenv::PackageDeps
end
