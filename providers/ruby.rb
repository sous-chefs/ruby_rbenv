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

include Chef::Rbenv::ShellHelpers

def load_current_resource
  @rubie      = new_resource.definition
  @root_path  = new_resource.root_path
  @user       = new_resource.user
end

action :install do
  perform_install
end

action :reinstall do
  perform_install
end

private

def perform_install
  if ruby_installed?
    Chef::Log.debug(
      "rbenv[#{@rubie}] #{which_rbenv} is already installed, so skipping")
  else
    install_start = Time.now

    install_ruby_dependencies

    Chef::Log.info(
      "Building rbenv[#{@rubie}] #{which_rbenv}, this could take a while...")

    # bypass block scoping issues
    rbenv_user    = @user
    rubie         = @rubie
    rbenv_prefix  = @root_path
    command       = %{rbenv install #{rubie}}

    rbenv_shell "#{command} #{which_rbenv}" do
      code        command
      user        rbenv_user    if rbenv_user
      root_path   rbenv_prefix  if rbenv_prefix

      action      :nothing
    end.run_action(:run)

    Chef::Log.debug("rbenv[#{@rubie}] #{which_rbenv} build time was " +
      "#{(Time.now - install_start)/60.0} minutes")
  end
end

def which_rbenv
  "(#{@user || 'system'})"
end

def ruby_installed?
  if Array(new_resource.action).include?(:reinstall)
    false
  else
    ::File.directory?(::File.join(rbenv_root, 'versions', @rubie))
  end
end

def install_ruby_dependencies
  case ::File.basename(new_resource.definition)
  when /^\d\.\d\.\d-/, /^rbx-/, /^ree-/
    pkgs = node['ruby_build']['install_pkgs_cruby']
  when /^jruby-/
    pkgs = node['ruby_build']['install_pkgs_jruby']
  end

  Array(pkgs).each do |pkg|
    package pkg do
      action :nothing
    end.run_action(:install)
  end
end
