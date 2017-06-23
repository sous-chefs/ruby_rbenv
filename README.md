# ruby_rbenv Chef Cookbook

[![Build Status](https://travis-ci.org/sous-chefs/ruby_rbenv.svg?branch=master)](https://travis-ci.org/sous-chefs/ruby_rbenv) [![Cookbook Version](https://img.shields.io/cookbook/v/ruby_rbenv.svg)](https://supermarket.chef.io/cookbooks/ruby_rbenv)

## Description

Manages [rbenv][rbenv_site] and its installed Rubies. Several lightweight resources and providers ([LWRPs][lwrp]) are also defined.

**WARNING**: As of version 1.0 this cookbook was renamed from rbenv to ruby_rbenv so it could be uploaded to the Supermarket. Attributes and resources (LWRPs) retain the rbenv namespace for compatibility, but if you wrap this cookbook you'll need to update the recipes you include. Use 0.9.0 if you need the existing name.

## Requirements

### Platforms

The following platforms have been tested with this cookbook, meaning that the recipes and LWRPs run on these platforms without error:

- Arch
- Debian derivitives (Debian 7+, Ubuntu 12.04+, Linux Mint)
- Freebsd
- Fedora
- Gentoo
- Mac OS X
- RHEL deritivites (RHEL, CentOS, Amazon Linux, Oracle, Scientific Linux)

Please [report][issues] any additional platforms so they can be added.

### Chef

This cookbook requires Chef 12.1+.

### Cookbooks

- [ruby_build cookbook][ruby_build_cb]
- java cookbook if installing jruby (recommended, but not required in the metadata)

## Usage

### rbenv Installed System-Wide with Rubies

Most likely, this is the typical case. Include `recipe[ruby_rbenv::system]` in your run_list and override the defaults you want changed. See [below](#attributes) for more details.

If your platform is the Mac, you may need to modify your [profile](#mac-system-note).

### rbenv Installed For A Specific User with Rubies

If you want a per-user install (like on a Mac/Linux workstation for development, CI, etc.), include `recipe[ruby_rbenv::user]` in your run_list and add a user hash to the `user_installs` attribute list. For example:

```ruby
node.default['rbenv']['user_installs'] = [
  { 'user'    => 'tflowers',
    'rubies'  => ['1.9.3-p0', 'jruby-1.6.5'],
    'global'  => '1.9.3-p0',
    'gems'    => {
      '1.9.3-p0'    => [
        { 'name'    => 'bundler',
          'version' => '1.1.rc.5'
        },
        { 'name'    => 'rake' }
      ],
      'jruby-1.6.5' => [
        { 'name'    => 'rest-client' }
      ]
    }
  }
]
```

See [below](#attributes) for more details.

### rbenv Installed System-Wide and LWRPs Defined

If you want to manage your own rbenv environment with the provided LWRPs, then include `recipe[ruby_rbenv::system_install]` in your run_list to prevent a default rbenv Ruby being installed. See the [Resources and Providers](#lwrps) section for more details.

If your platform is the Mac, you may need to modify your [profile](#mac-system-note).

### rbenv Installed For A Specific User and LWRPs Defined

If you want to manage your own rbenv environment for users with the provided LWRPs, then include `recipe[ruby_rbenv::user_install]` in your run_list and add a user hash to the `user_installs` attribute list. For example:

```ruby
node.default['rbenv']['user_installs'] = [
  { 'user' => 'tflowers' }
]
```

See the [Resources and Providers](#lwrps) section for more details.

### Ultra-Minimal Access To LWRPs

Simply include `recipe[ruby_rbenv]` in your run_list and the LWRPs will be available to use in other cookbooks. See the [Resources and Providers](#lwrps) section for more details.

## Recipes

### default

Installs the rbenv gem and initializes Chef to use the Lightweight Resources and Providers ([LWRPs][lwrp]).

Use this recipe explicitly if you only want access to the LWRPs provided.

### system_install

Installs the rbenv codebase system-wide (that is, into `/usr/local/rbenv`). This recipe includes _default_.

Use this recipe by itself if you want rbenv installed system-wide but want to handle installing Rubies, invoking LWRPs, etc..

### system

Installs the rbenv codebase system-wide (that is, into `/usr/local/rbenv`) and installs rubies driven off attribute metadata. This recipe includes _default_ and _system_install_.

Use this recipe by itself if you want rbenv installed system-wide with rubies installed.

### user_install

Installs the rbenv codebase for a list of users (selected from the `node['rbenv']['user_installs']` hash). This recipe includes _default_.

Use this recipe by itself if you want rbenv installed for specific users in isolation but want each user to handle installing Rubies, invoking LWRPs, etc.

### user

Installs the rbenv codebase for a list of users (selected from the `node['rbenv']['user_installs']` hash) and installs rubies driven off attribte metadata. This recipe includes _default_ and _user_install_.

Use this recipe by itself if you want rbenv installed for specific users in isolation with rubies installed.

## Attributes

### git_url

The Git URL which is used to install rbenv.

The default is `"git://github.com/sstephenson/rbenv.git"`.

### git_ref

A specific Git branch/tag/reference to use when installing rbenv. For example, to pin rbenv to a specific release:

```ruby
node.default['rbenv']['git_ref'] = "v0.2.1"
```

The default is `"v0.4.0"`.

### upgrade

Determines how to handle installing updates to the rbenv. There are currently 2 valid values:

- `"none"`, `false`, or `nil`: will not update rbenv and leave it in its current state.
- `"sync"` or `true`: updates rbenv to the version specified by the `git_ref` attribute or the head of the master branch by default.

The default is `"none"`.

### root_path

The path prefix to rbenv in a system-wide installation.

The default is `"/usr/local/rbenv"`.

### patch_url

A url to a patch file for your ruby install.

The default is `nil`.

### patch_file

A path to a patch file for your ruby install.

The default is `nil`.

### rubies

A list of additional system-wide rubies to be built and installed using the [ruby_build cookbook][ruby_build_cb]. You **must** include `recipe[ruby_build]` in your run_list for the `rbenv_ruby` LWRP to work properly. For example:

```ruby
node.default['rbenv']['rubies'] = [ "1.9.3-p0", "jruby-1.6.5" ]
```

The default is an empty array: `[]`.

Additional environment variables can be passed to ruby_build via the environment variable. For example:

```ruby
node.default['rbenv']['rubies'] = [ "1.9.3-p0", "jruby-1.6.5",
  {
  :name => '1.9.3-327',
  :environment => { 'CFLAGS' => '-march=native -O2 -pipe' }
  }
]
```

### plugins

A list of plugins to be installed into the system (or user) install of rbenv. Provide a hash of name and git_url for each plugin to be installed, with optional revision.

```ruby
node.default['rbenv']['plugins'] = [
  {
    :name => "rbenv-vars",
    :git_url => 'git://github.com/sstephenson/rbenv-vars.git'
  },
  {
    :name => 'rbenv-update',
    :git_url => 'git://github.com/rkh/rbenv-update.git',
    :revision => 'master'
  } ]
```

The same applies for user_installs.

### user_rubies

A list of additional system-wide rubies to be built and installed (using the [ruby_build cookbook][ruby_build_cb]) per-user when not explicitly set. For example:

```ruby
node.default['rbenv']['user_rubies'] = [ "1.8.7-p352" ]
```

The default is an empty array: `[]`.

Additional environment variables can be passed to ruby_build via the environment variable. For example:

```ruby
node.default['rbenv']['user_rubies'] = [ "1.8.7-p352",
  {
  :name => '1.9.3-327',
  :environment => { 'CFLAGS' => '-march=native -O2 -pipe' }
  }
]
```

### gems

A hash of gems to be installed into arbitrary rbenv-managed rubies system wide. See the [rbenv_gem](#lwrps-rbgem) resource for more details about the options for each gem hash and target Ruby environment. For example:

```ruby
node.default['rbenv']['gems'] = {
  '1.9.3-p0' => [
    { 'name'    => 'vagrant' },
    { 'name'    => 'bundler'
      'version' => '1.1.rc.5'
    }
  ],
  '1.8.7-p352' => [
    { 'name'    => 'nokogiri' }
  ]
}
```

The default is an empty hash: `{}`.

### user_gems

A hash of gems to be installed into arbitrary rbenv-managed rubies for each user when not explicitly set. See the [rbenv_gem](#lwrps-rbgem) resource for more details about the options for each gem hash and target Ruby environment. See the [gems attribute](#attributes-gems) for an example.

The default is an empty hash: `{}`.

### plugins

A list of plugins to be installed system-wide. See the [rbenv_plugin](#lwrps-plugin) resource for details about the options.

```ruby
node.default['rbenv']['plugins'] = [
  { 'name' => 'rbenv-vars',
    'git_url' => 'https://github.com/sstephenson/rbenv-vars.git' },
  { 'name' => 'rbenv-gem-rehash',
    'git_url' => 'https://github.com/sstephenson/rbenv-gem-rehash.git',
    'git_ref' => '4d7b92de4' }
]
```

The default is an empty array: `[]`.

### user_plugins

As with user_gems, a list of plugins to be installed for each user when not explicitly set.

The default is an empty array: `[]`.

### vagrant/system_chef_solo

If using the `vagrant` recipe, this sets the path to the package-installed _chef-solo_ binary.

The default is `"/opt/ruby/bin/chef-solo"`.

### create_profiled

The user's shell needs to know about rbenv's location and set up the PATH environment variable. This is handled in the [system_install](#recipes-system_install) and [user_install](#recipes-user_install) recipes by dropping off `/etc/profile.d/rbenv.sh`. However, this requires root privilege, which means that a user cannot use a "user install" for only their user.

Set this attribute to `false` to skip creation of the `/etc/profile.d/rbenv.sh` template. For example:

```ruby
node.default['rbenv']['create_profiled'] = false
```

The default is `true`.

## Resources and Providers

### rbenv_global

This resource sets the global version of Ruby to be used in all shells, as per the [rbenv global docs][rbenv_3_1].

#### Actions

Action | Description                                                                                            | Default
------ | ------------------------------------------------------------------------------------------------------ | -------
create | Sets the global version of Ruby to be used in all shells. See 3.1 rbenv global `(1)` for more details. | Yes

1. [3.1 rbenv global][rbenv_3_1]

#### Attributes

Attribute     | Description                                                                                                                                                                                                    | Default Value
------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------
rbenv_version | **Name attribute:** a version of Ruby being managed by rbenv. **Note:** the version of Ruby must already be installed--this LWRP will not install it automatically.                                            | `nil`
user          | A users's isolated rbenv installation on which to apply an action. The default value of `nil` denotes a system-wide rbenv installation is being targeted. **Note:** if specified, the user must already exist. | `nil`
root_path     | The path prefix to rbenv installation, for example: `/opt/rbenv`.                                                                                                                                              | `nil`

#### Examples

##### Set A Ruby As Global

```
rbenv_global "1.8.7-p352"
```

##### Set System Ruby As Global

```ruby
rbenv_global "system"
```

##### Set A Ruby As Global For A User

```ruby
rbenv_global "jruby-1.7.0-dev" do
  user "tflowers"
end
```

### rbenv_script

This resource is a wrapper for the `script` resource which wraps the code block in an rbenv-aware environment. See the Opscode [script resource][script_resource] page and the [rbenv shell][rbenv_3_3] documentation for more details.

#### Actions

Action  | Description             | Default
------- | ----------------------- | -------
run     | Run the script          | Yes
nothing | Do not run this command |

Use `action :nothing` to set a command to only run if another resource notifies it.

#### Attributes

Attribute     | Description                                                                                                                                                                                                    | Default Value
------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -----------------------
name          | **Name attribute:** Name of the command to execute.                                                                                                                                                            | name
rbenv_version | A version of Ruby being managed by rbenv.                                                                                                                                                                      | `nil`
root_path     | The path prefix to rbenv installation, for example: `/opt/rbenv`.                                                                                                                                              | `nil`
code          | Quoted script of code to execute.                                                                                                                                                                              | `nil`
creates       | A file this command creates - if the file exists, the command will not be run.                                                                                                                                 | `nil`
cwd           | Current working director to run the command from.                                                                                                                                                              | `nil`
environment   | A has of environment variables to set before running this command.                                                                                                                                             | `nil`
group         | A group or group ID that we should change to before running this command.                                                                                                                                      | `nil`
path          | An array of paths to use when searching for the command.                                                                                                                                                       | `nil`, uses system path
returns       | The return value of the command (may be an array of accepted values) - this resource raises an exception if the return value(s) do not match.                                                                  | `0`
timeout       | How many seconds to let the command run before timing out.                                                                                                                                                     | `nil`
user          | A users's isolated rbenv installation on which to apply an action. The default value of `nil` denotes a system-wide rbenv installation is being targeted. **Note:** if specified, the user must already exist. | `nil`
umask         | Umask for files created by the command.                                                                                                                                                                        | `nil`

#### Examples

##### Run A Rake Task

```
rbenv_script "migrate_rails_database" do
  rbenv_version "1.8.7-p352"
  user          "deploy"
  group         "deploy"
  cwd           "/srv/webapp/current"
  code          %{rake RAILS_ENV=production db:migrate}
end
```

### rbenv_gem

This resource is a close analog of the `gem_package` resource/provider which is rbenv-aware. See the Opscode [package resource][package_resource] and [gem package options][gem_package_options] pages for more details.

#### Actions

Action  | Description                                                               | Default
------- | ------------------------------------------------------------------------- | -------
install | Install a gem - if version is provided, install that specific version.    | Yes
upgrade | Upgrade a gem - if version is provided, upgrade to that specific version. | remove  | Remove a gem. | purge | Purge a gem. |

#### Attributes

Attribute     | Description                                                                                                                                                                                                    | Default Value
------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------
package_name  | **Name attribute:** the name of the gem to install.                                                                                                                                                            | `nil`
rbenv_version | A version of Ruby being managed by rbenv.                                                                                                                                                                      | `"global"`
root_path     | The path prefix to rbenv installation, for example: `/opt/rbenv`.                                                                                                                                              | `nil`
version       | The specific version of the gem to install/upgrade.                                                                                                                                                            | `nil`
options       | Add additional options to the underlying gem command.                                                                                                                                                          | `nil`
source        | Provide an additional source for gem providers (such as RubyGems). This can also include a file system path to a `.gem` file such as `/tmp/json-1.5.1.gem`.                                                    | `nil`
user          | A users's isolated rbenv installation on which to apply an action. The default value of `nil` denotes a system-wide rbenv installation is being targeted. **Note:** if specified, the user must already exist. | `nil`

#### Examples

##### Install A Gem

```
rbenv_gem "thor" do
  rbenv_version   "1.8.7-p352"
  action          :install
end

rbenv_gem "json" do
  rbenv_version   "1.8.7-p330"
end

rbenv_gem "nokogiri" do
  rbenv_version   "jruby-1.5.6"
  version         "1.5.0.beta.4"
  action          :install
end
```

**Note:** the install action is default, so the second example is a more common usage.

##### Install A Gem From A Local File

```
rbenv_gem "json" do
  rbenv_version   "ree-1.8.7-2011.03"
  source          "/tmp/json-1.5.1.gem"
  version         "1.5.1"
end
```

##### Keep A Gem Up To Date

```
rbenv_gem "homesick" do
  action :upgrade
end
```

**Note:** the global rbenv Ruby will be targeted if no `rbenv_version` attribute is given.

##### Remove A Gem

```
rbenv_gem "nokogiri" do
  rbenv_version   "jruby-1.5.6"
  version         "1.4.4.2"
  action          :remove
end
```

### rbenv_plugin

Installs rbenv plugins.

#### Attributes

Attribute | Description                                                                                                                                                                                                    | Default Value
--------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------
name      | **Name attribute:** the name of the plugin to install.                                                                                                                                                         | `nil`
root_path | The path prefix to rbenv installation, for example: `/opt/rbenv`.                                                                                                                                              | `nil`
git_url   | The git URL of the plugin repository to clone.                                                                                                                                                                 | `nil`
git_ref   | The git revision (branch name or SHA) of the repository to checkout.                                                                                                                                           | `'master'`
user      | A users's isolated rbenv installation on which to apply an action. The default value of `nil` denotes a system-wide rbenv installation is being targeted. **Note:** if specified, the user must already exist. | `nil`

##### Install a plugin

```
rbenv_plugin 'rbenv-vars' do
  git_url 'https://github.com/sstephenson/rbenv-vars.git'
  user 'deploy'
end
```

### rbenv_rehash

This resource installs shims for all Ruby binaries known to rbenv, as per the [rbenv rehash docs][rbenv_3_6].

#### Actions

Action  | Description             | Default
------- | ----------------------- | -------
run     | Run the script          | Yes
nothing | Do not run this command |

Use `action :nothing` to set a command to only run if another resource notifies it.

#### Attributes

Attribute | Description                                                                                                                                                                                                    | Default Value
--------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------
name      | **Name attribute:** Name of the command to execute.                                                                                                                                                            | name
user      | A users's isolated rbenv installation on which to apply an action. The default value of `nil` denotes a system-wide rbenv installation is being targeted. **Note:** if specified, the user must already exist. | `nil`
root_path | The path prefix to rbenv installation, for example: `/opt/rbenv`.                                                                                                                                              | `nil`

#### Examples

##### Rehash A System-Wide rbenv

```
rbenv_rehash "Doing the rehash dance"
```

##### Rehash A User's rbenv

```
rbenv_rehash "Rehashing tflowers' rbenv" do
  user  "tflowers"
end
```

### rbenv_ruby

This resource uses the [ruby-build][ruby_build_site] framework to build and install Ruby versions from definition files.

**Note:** this LWRP requires the [ruby_build cookbook][ruby_build_cb] to be in the run list to perform the builds.

#### Actions

Action  | Description                                                                                        | Default
------- | -------------------------------------------------------------------------------------------------- | -------------
install | Build and install a Ruby from a definition file. See the ruby-build readme `(1)` for more details. | Yes reinstall | Force a recompiliation of the Ruby from source. The :install action will skip a build if the target install directory already exists. |

1. [ruby-build readme][rb_readme]

#### Attributes

Attribute  | Description                                                                                                                         | Default Value
---------- | ----------------------------------------------------------------------------------------------------------------------------------- | ---------------------
definition | **Name attribute:** the name of a built-in definition `(1)` or the name of the ruby installed by a ruby-build definition file `(2)` | `nil` definition_file | The path to a ruby-build definition file. | `nil` user | A users's isolated rbenv installation on which to apply an action. The default value of `nil` denotes a system-wide rbenv installation is being targeted. **Note:** if specified, the user must already exist. | `nil` root_path | The path prefix to rbenv installation, for example: `/opt/rbenv`. | `nil` rbenv_action | The action that rbenv takes to install ruby via the command line. By default this is 'install' which results in a command such as `rbenv install ruby 2.2.0`. When using the rvm-download rbenv plugin use 'download' to have the provider execute a command such as `rbenv download 2.2.0`. | `install`

1. [built-in definition][rb_definitions]
2. the recipe checks for the existence of the naming attribute under the root_path, and if not found invokes ruby-build with the definition file as an argument

#### Examples

##### Install Ruby From ruby-build

```
rbenv_ruby "ree-1.8.7-2011.03" do
  action :install
end

rbenv_ruby "jruby-1.6.5"
```

**Note:** the install action is default, so the second example is a more common usage.

##### Reinstall Ruby

```
rbenv_ruby "ree-1.8.7-2011.03" do
  action :reinstall
end
```

##### Install a custom ruby

```
rbenv_ruby "2.0.0p116" do
  definition_file "/usr/local/rbenv/custom/2.0.0p116"
end
```

## System-Wide Mac Installation Note

This cookbook takes advantage of managing profile fragments in an `/etc/profile.d` directory, common on most Unix-flavored platforms. Unfortunately, Mac OS X does not support this idiom out of the box, so you may need to [modify][mac_profile_d] your user profile.

## Development

- Source hosted at [GitHub][repo]
- Report issues/Questions/Feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested. Ideally create a topic branch for every separate change you make.

## License and Author

Author:: [Fletcher Nichol][fnichol] ([fnichol@nichol.ca](mailto:fnichol@nichol.ca))

Copyright 2011, Fletcher Nichol

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

```
http://www.apache.org/licenses/LICENSE-2.0
```

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

[berkshelf]: http://berkshelf.com/
[chef_repo]: https://github.com/chef/chef-repo
[cheffile]: https://github.com/applicationsonline/librarian/blob/master/lib/librarian/chef/templates/Cheffile
[fnichol]: https://github.com/fnichol
[gem_package_options]: https://docs.chef.io/resource_gem_package.html#attributes
[issues]: https://github.com/chef-rbenv/ruby-rbenv/issues
[kgc]: https://github.com/websterclay/knife-github-cookbooks#readme
[librarian]: https://github.com/applicationsonline/librarian#readme
[lwrp]: https://docs.chef.io/lwrp_custom.html
[mac_profile_d]: http://hints.macworld.com/article.php?story=20011221192012445
[package_resource]: https://docs.chef.io/resource_package.html
[rb_definitions]: https://github.com/sstephenson/ruby-build/tree/master/share/ruby-build
[rb_readme]: https://github.com/sstephenson/ruby-build#readme
[rbenv_3_1]: https://github.com/sstephenson/rbenv#section_3.1
[rbenv_3_3]: https://github.com/sstephenson/rbenv#section_3.3
[rbenv_3_6]: https://github.com/sstephenson/rbenv#section_3.6
[rbenv_site]: https://github.com/sstephenson/rbenv
[repo]: https://github.com/chef-rbenv/ruby-rbenv
[ruby_build_cb]: https://supermarket.chef.io/cookbooks/ruby_build
[ruby_build_site]: https://github.com/sstephenson/ruby-build
[script_resource]: http://docs.chef.io/resource_script.html
