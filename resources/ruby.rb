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

default_action :install

property :definition, String, name_property: true
property :definition_file,String
property :root_path, String
property :user, String
property :environment, Hash
property :patch_url, String
property :patch_file, String
property :rbenv_action, String, default: 'install'

action :install do
  if ruby_build_missing?
    Chef::Log.warn(
      'ruby_build cookbook is missing. Please add to the run_list (Action will be skipped).')
  elsif ruby_installed?
    Chef::Log.debug("#{new_resource} is already installed - nothing to do")
  else
    install_start = Time.now

    install_ruby_dependencies

    Chef::Log.info("Building #{new_resource}, this could take a while...")

    patch_command = nil
    patch_command = "--patch < <(curl -sSL #{new_resource.patch_url})" if new_resource.patch_url
    patch_command = "--patch < #{new_resource.patch_file}" if new_resource.patch_file
    command = %(rbenv #{new_resource.rebenv_action} #{new_resource.definition} #{new_resource.patch_command})

    rbenv_script "#{command} #{which_rbenv}" do
      code command
      user new_resource.rbenv_user if new_resource.rbenv_user
      root_path new_resource.root_path if new_resource.root_path
      environment new_resource.rbenv_env if new_resource.rbenv_env
      action :nothing
    end.run_action(:run)

    Chef::Log.debug("#{new_resource} build time was " \
      "#{(Time.now - install_start) / 60.0} minutes")
  end
end

action :reinstall do

end

action_class do
  def ruby_build_missing?
    !run_context.loaded_recipe?('ruby_build')
  end

  def ruby_installed?
    if Array(new_resource.action).include?(:reinstall)
      false
    else
      ::File.directory?(::File.join(rbenv_root, 'versions', new_resource.definition))
    end
  end

  def install_ruby_dependencies
    definition = ::File.basename(new_resource.definition)

    case definition
    when /^\d\.\d\.\d/, /^rbx-/, /^ree-/
      pkgs = node['ruby_build']['install_pkgs_cruby']
    when /^jruby-/
      pkgs = node['ruby_build']['install_pkgs_jruby']
    end

    pkgs.each do |pkg|
      package pkg do
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
