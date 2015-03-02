#
# Cookbook Name:: rbenv
# Provider:: ruby
#
# Author:: Fletcher Nichol <fnichol@nichol.ca>
#
# Copyright 2011, Fletcher Nichol
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

include Chef::Rbenv::ScriptHelpers

def load_current_resource
  @rubie      = new_resource.definition
  @definition_file = new_resource.definition_file
  @root_path  = new_resource.root_path
  @user       = new_resource.user
  @environment = new_resource.environment
end

action :install do
  perform_install
end

action :reinstall do
  perform_install
end

private

def install_rvm_download
  user = @user
  root_path = @root_path
  rbenv_plugin 'rvm-download' do
    git_url   node['rbenv']['rvm_download']['git_url']
    git_ref   node['rbenv']['rvm_download']['git_ref'] if node['rbenv']['rvm_download']['git_ref']
    user      user
    root_path root_path if root_path
  end.run_action(:install)
end

def download_enabled?
  !!node['rbenv']['rvm_download']['enable']
end

def perform_install
  if ruby_build_missing?
    Chef::Log.warn(
      "ruby_build cookbook is missing. Please add to the run_list (Action will be skipped).")
  elsif ruby_installed?
    Chef::Log.debug("#{new_resource} is already installed - nothing to do")
  else
    install_start = Time.now

    install_ruby_dependencies

    Chef::Log.info("Building #{new_resource}, this could take a while...")

    download_or_install = download_enabled?? 'download' : 'install'
    install_rvm_download if download_enabled?

    # bypass block scoping issues
    rbenv_user    = @user
    rubie         = @rubie
    definition    = @definition_file || @rubie
    rbenv_prefix  = @root_path
    rbenv_env     = @environment
    command       = %{rbenv #{download_or_install} #{definition}}

    rbenv_script "#{command} #{which_rbenv}" do
      code        command
      user        rbenv_user    if rbenv_user
      root_path   rbenv_prefix  if rbenv_prefix
      environment rbenv_env     if rbenv_env

      action      :nothing
    end.run_action(:run)

    Chef::Log.debug("#{new_resource} build time was " +
      "#{(Time.now - install_start)/60.0} minutes")

    new_resource.updated_by_last_action(true)
  end
end

def ruby_installed?
  if Array(new_resource.action).include?(:reinstall)
    false
  else
    ::File.directory?(::File.join(rbenv_root, 'versions', @rubie))
  end
end

def ruby_build_missing?
  ! run_context.loaded_recipe?("ruby_build")
end

def install_ruby_dependencies
  definition = ::File.basename(new_resource.definition)

  case definition
  when /^\d\.\d\.\d/, /^rbx-/, /^ree-/
    pkgs = node['ruby_build']['install_pkgs_cruby']
  when /^jruby-/
    pkgs = node['ruby_build']['install_pkgs_jruby']
  end

  Array(pkgs).each do |pkg|
    package pkg do
      action :nothing
    end.run_action(:install)
  end

  ensure_java_environment if definition =~ /^jruby-/
end

def ensure_java_environment
  begin
    resource_collection.find(
      "ruby_block[update-java-alternatives]"
    ).run_action(:create)
  rescue Chef::Exceptions::ResourceNotFound
    # have pity on my soul
    Chef::Log.info "The java cookbook does not appear to in the run_list."
  end
end
