#
# Cookbook:: ruby_rbenv
# Resource:: ruby
#
# Author:: Fletcher Nichol <fnichol@nichol.ca>
# Author:: Dan Webb <dan.wenn@damacus.io>
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
provides :rbenv_ruby

property :definition, String, name_property: true
property :definition_file, String
property :root_path, String
property :user, String
property :environment, Hash
property :patch_url, String
property :patch_file, String
property :rbenv_action, String, default: 'install'
property :ruby_build_ref, String, default: 'master'
property :global, [true, false], default: false

action :install do
  begin
    install_start = Time.now

    rbenv_plugin 'ruby-build' do
      git_url 'https://github.com/rbenv/ruby-build.git'
      git_ref new_resource.ruby_build_version
    end

    install_ruby_dependencies

    Chef::Log.info("Building #{new_resource}, this could take a while...")

    patch_command = "--patch < <(curl -sSL #{new_resource.patch_url})" if new_resource.patch_url
    patch_command = "--patch < #{new_resource.patch_file}" if new_resource.patch_file
    command = %(rbenv #{new_resource.rbenv_action} #{new_resource.definition} #{patch_command})

    rbenv_script "#{command} #{which_rbenv}" do
      code command
      user new_resource.user if new_resource.user
      root_path new_resource.root_path if new_resource.root_path
      environment new_resource.environment if new_resource.environment
      action :nothing
    end.run_action(:run)

    Chef::Log.debug("#{new_resource} build time was " \
      "#{(Time.now - install_start) / 60.0} minutes")
  rescue
    Chef::Log.warn('Ruby version already installed')
  end
end

action :reinstall do
end

action_class do
  include Chef::Rbenv::ScriptHelpers

  def ruby_installed?
    if Array(new_resource.action).include?(:reinstall)
      false
    elsif ::File.directory?(::File.join(rbenv_root,
      'versions',
      new_resource.definition))
      true
    end
  end

  def install_ruby_dependencies
    case ::File.basename(new_resource.definition)
    when /^jruby-/
      package jruby_package_deps do
        action :nothing
      end.run_action(:install)
    when /^rbx-/
      package rbx_package_deps do
        action :nothing
      end.run_action(:install)
    end

    ensure_java_environment if definition =~ /^jruby-/
  end

  def ensure_java_environment
    resource_collection.find(
      'ruby_block[update-java-alternatives]'
    ).run_action(:create)
  rescue Chef::Exceptions::ResourceNotFound
    # have pity on my soul
    Chef::Log.info 'The java cookbook does not appear to in the run_list.'
  end
end
