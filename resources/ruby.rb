#
# Cookbook:: ruby_rbenv
# Resource:: ruby
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

actions :install, :reinstall
default_action :install

provides :rbenv_ruby

attribute :definition, kind_of: String, name_attribute: true
attribute :definition_file,	kind_of: String
attribute :root_path,   kind_of: String
attribute :user,        kind_of: String
attribute :environment, kind_of: Hash
attribute :patch_url,   kind_of: String
attribute :patch_file,  kind_of: String
attribute :rbenv_action, kind_of: String, default: 'install'

def initialize(*args)
  super
  @rbenv_version = @definition
end

def to_s
  "#{super} (#{@user || 'system'})"
end
