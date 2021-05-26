#
# Cookbook:: ruby_rbenv
# Resource:: script
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
provides :rbenv_script
unified_mode true
use '_partial/_common'

property :rbenv_version,
        String,
        description: 'Ruby version to run the script on.'

property :code,
         String,
        description: 'Script code to run.'

property :creates,
        String,
        description: 'Prevent the script from creating a file when that file already exists.'

property :cwd,
        String,
        description: 'The current working directory from which the command will be run.'

property :environment,
        Hash,
        description: 'A Hash of environment variables in the form of ({"ENV_VARIABLE" => "VALUE"}).'

property :group,
        String,
        description: 'The group ID to run the command as.'

property :path,
        Array,
        description: 'Path to add to environment.'

property :returns,
        Array, default: [0],
        description: 'The return value for a command. This may be an array of accepted values.'

property :timeout,
        Integer,
        description: 'The amount of time (in seconds) to wait for the script to complete.'

property :umask,
        [String, Integer],
        description: 'The file mode creation mask, or umask.'

property :live_stream,
        [true, false],
        default: false,
        description: 'Live stream the output from the script to the console.'

action :run do
  bash new_resource.name do
    code script_code
    user new_resource.user if new_resource.user
    creates new_resource.creates if new_resource.creates
    cwd new_resource.cwd if new_resource.cwd
    group new_resource.group if new_resource.group
    returns new_resource.returns if new_resource.returns
    timeout new_resource.timeout if new_resource.timeout
    umask new_resource.umask if new_resource.umask
    environment(script_environment)
    live_stream new_resource.live_stream
  end
end

action_class do
  include Chef::Rbenv::Helpers
end
