# <a name="title"></a> chef-rbenv [![Build Status](https://secure.travis-ci.org/fnichol/chef-rbenv.png?branch=master)](http://travis-ci.org/fnichol/chef-rbenv)

## <a name="description"></a> Description

Manages [rbenv][rbenv_site] and its installed Rubies.
Several lightweight resources and providers ([LWRPs][lwrp]) are also defined.

## <a name="usage"></a> Usage

### <a name="usage-system-rubies"></a> rbenv Installed System-Wide with Rubies

Most likely, this is the typical case. Include `recipe[rbenv::system]` in your
run\_list and override the defaults you want changed. See [below](#attributes)
for more details.

### <a name="usage-user-rubies"></a> rbenv Installed For A Specific User with Rubies

If you want a per-user install (like on a Mac/Linux workstation for
development, CI, etc.), include `recipe[rbenv::user]` in your run\_list and
add a user hash to the `user_installs` attribute list. For example:

    node['rbenv']['user_installs'] = [
      { 'user'    => 'tflowers',
        'rubies'  => ['1.9.3-p0', 'jruby-1.6.5'],
        'global'  => '1.9.3-p0',
        'gems'    => {
          '1.9.3-p0'    => [
            { 'name'    => 'bundler'
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

See [below](#attributes) for more details.

### <a name="usage-system"></a> rbenv Installed System-Wide and LWRPs Defined

If you want to manage your own rbenv environment with the provided
LWRPs, then include `recipe[rbenv::system_install]` in your run\_list
to prevent a default rbenv Ruby being installed. See the
[Resources and Providers](#lwrps) section for more details.

### <a name="usage-user"></a> rbenv Installed For A Specific User and LWRPs Defined

If you want to manage your own rbenv environment for users with the provided
LWRPs, then include `recipe[rbenv::user_install]` in your run\_list and add a
user hash to the `user_installs` attribute list. For example:

    node['rbenv']['user_installs'] = [
      { 'user' => 'tflowers' }
    ]

See the [Resources and Providers](#lwrps) section for more details.

### <a name="usage-minimal"></a> Ultra-Minimal Access To LWRPs

Simply include `recipe[rbenv]` in your run\_list and the LWRPs will be
available to use in other cookboks. See the [Resources and Providers](#lwrps)
section for more details.

### <a name="usage-other"></a> Other Use Cases

* If node is running in a Vagrant VM, then including `recipe[rbenv::vagrant]`
in your run\_list can help with resolving the *chef-solo* binary on subsequent

## <a name="requirements"></a> Requirements

### <a name="requirements-chef"></a> Chef

Tested on 0.10.4 and 0.10.8 but newer and older version should work just
fine. File an [issue][issues] if this isn't the case.

### <a name="requirements-platform"></a> Platform

The following platforms have been tested with this cookbook, meaning that
the recipes and LWRPs run on these platforms without error:

* ubuntu (10.04/10.10/11.04/11.10)
* debian (6.0)

Please [report][issues] any additional platforms so they can be added.

### <a name="requirements-cookbooks"></a> Cookbooks

There are **no** external cookbook dependencies. However, if you
want to manage Ruby installations or use the `rbenv_ruby` LWRP then you will
need to include the [ruby\_build cookbook][ruby_build_cb].

## <a name="installation"></a> Installation

Depending on the situation and use case there are several ways to install
this cookbook. All the methods listed below assume a tagged version release
is the target, but omit the tags to get the head of development. A valid
Chef repository structure like the [Opscode repo][chef_repo] is also assumed.

### <a name="installation-librarian"></a> Using Librarian

[Librarian-Chef][librarian] is a bundler for your Chef cookbooks.
Include a reference to the cookbook in a [Cheffile][cheffile] and run
`librarian-chef install`. To install Librarian-Chef:

    gem install librarian
    cd chef-repo
    librarian-chef init

Or to reference the Git version:

    cat >> Cheffile <<END_OF_CHEFFILE
    cookbook 'rbenv',
      :git => 'https://github.com/fnichol/chef-rbenv', :ref => 'v0.6.4'
    END_OF_CHEFFILE
    librarian-chef install

### <a name="installation-kgc"></a> Using knife-github-cookbooks

The [knife-github-cookbooks][kgc] gem is a plugin for *knife* that supports
installing cookbooks directly from a GitHub repository. To install with the
plugin:

    gem install knife-github-cookbooks
    cd chef-repo
    knife cookbook github install fnichol/chef-rbenv/v0.6.4

### <a name="installation-tarball"></a> As a Tarball

If the cookbook needs to downloaded temporarily just to be uploaded to a Chef
Server or Opscode Hosted Chef, then a tarball installation might fit the bill:

    cd chef-repo/cookbooks
    curl -Ls https://github.com/fnichol/chef-rbenv/tarball/v0.6.4 | tar xfz - && \
      mv fnichol-chef-rbenv-* rbenv

### <a name="installation-gitsubmodule"></a> As a Git Submodule

A dated practice (which is discouraged) is to add cookbooks as Git
submodules. This is accomplishes like so:

    cd chef-repo
    git submodule add git://github.com/fnichol/chef-rbenv.git cookbooks/rbenv
    git submodule init && git submodule update

**Note:** the head of development will be linked here, not a tagged release.

### <a name="installation-platform"></a> From the Opscode Community Platform

This cookbook is not currently available on the site due to the flat
namespace for cookbooks.

## <a name="recipes"></a> Recipes

### <a name="recipes-default"></a> default

Installs the rbenv gem and initializes Chef to use the Lightweight Resources
and Providers ([LWRPs][lwrp]).

Use this recipe explicitly if you only want access to the LWRPs provided.

### <a name="recipes-system-install"></a> system_install

Installs the rbenv codebase system-wide (that is, into `/usr/local/rbenv`). This
recipe includes *default*.

Use this recipe by itself if you want rbenv installed system-wide but want
to handle installing Rubies, invoking LWRPs, etc..

### <a name="recipes-system"></a> system

Installs the rbenv codebase system-wide (that is, into `/usr/local/rbenv`) and
installs rubies driven off attribute metadata. This recipe includes *default*
and *system_install*.

Use this recipe by itself if you want rbenv installed system-wide with rubies
installed.

### <a name="recipes-user-install"></a> user_install

Installs the rbenv codebase for a list of users (selected from the
`node['rbenv']['user_installs']` hash). This recipe includes *default*.

Use this recipe by itself if you want rbenv installed for specific users in
isolation but want each user to handle installing Rubies, invoking LWRPs, etc.

### <a name="recipes-user"></a> user

Installs the rbenv codebase for a list of users (selected from the
`node['rbenv']['user_installs']` hash) and installs rubies driven off attribte
metadata. This recipe includes *default* and *user_install*.

Use this recipe by itself if you want rbenv installed for specific users in
isolation with rubies installed.

### <a name="recipes-vagrant"></a> vagrant

An optional recipe if Chef is installed in a non-rbenv Ruby in a
[Vagrant][vagrant] virtual machine. This recipe installs a `chef-solo`
wrapper script so Chef doesn't need to be re-installed in the global rbenv Ruby.

## <a name="attributes"></a> Attributes

### <a name="attributes-git-url"></a> git_url

The Git URL which is used to install rbenv.

The default is `"git://github.com/sstephenson/rbenv.git"`.

### <a name="attributes-git-ref"></a> git_ref

A specific Git branch/tag/reference to use when installing rbenv. For
example, to pin rbenv to a specific release:

    node['ruby_build']['git_ref'] = "v0.2.1"

The default is `"master"`.

### <a name="attributes-upgrade"></a> upgrade

Determines how to handle installing updates to the rbenv. There are currently
2 valid values:

* `"none"`, `false`, or `nil`: will not update rbenv and leave it in its
  current state.
* `"sync"` or `true`: updates rbenv to the version specified by the
  `git_ref` attribute or the head of the master branch by default.

The default is `"none"`.

### <a name="attributes-root-path"></a> root_path

The path prefix to rbenv in a system-wide installation.

The default is `"/usr/local/rbenv"`.

### <a name="attributes-rubies"></a> rubies

A list of additional system-wide rubies to be built and installed using the
[ruby\_build cookbook][ruby_build_cb]. You **must** include `recipe[ruby_build]`
in your run\_list for the `rbenv_ruby` LWRP to work properly. For example:

    node['rbenv']['rubies'] = [ "1.9.3-p0", "jruby-1.6.5" ]

The default is an empty array: `[]`.

### <a name="attributes-user-rubies"></a> user_rubies

A list of additional system-wide rubies to be built and installed (using the
[ruby\_build cookbook][ruby_build_cb]) per-user when not explicitly set.
For example:

    node['rbenv']['user_rubies'] = [ "1.8.7-p352" ]

The default is an empty array: `[]`.

### <a name="attributes-gems"></a> gems

A hash of gems to be installed into arbitrary rbenv-managed rubies system wide.
See the [rbenv_gem](#lwrps-rbgem) resource for more details about the options
for each gem hash and target Ruby environment. For example:

    node['rbenv']['gems'] = {
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

The default is an empty hash: `{}`.

### <a name="attributes-user-gems"></a> user_gems

A hash of gems to installed into arbitrary rbenv-managed rubies for each user
when not explicitly set. See the [rbenv_gem](#lwrps-rbgem) resource for more
details about the options for each gem hash and target Ruby environment. See
the [gems attribute](#attributes-gems) for an example.

The default is an empty hash: `{}`.

### <a name="attributes-vagrant-system-chef-solo"></a> vagrant/system_chef_solo

If using the `vagrant` recipe, this sets the path to the package-installed
*chef-solo* binary.

The default is `"/opt/ruby/bin/chef-solo"`.

## <a name="lwrps"></a> Resources and Providers

### <a name="lwrps-rg"></a> rbenv_global

This resource sets the global version of Ruby to be used in all shells, as per
the [rbenv global docs][rbenv_3_1].

#### <a name="lwrps-rg-actions"></a> Actions

<table>
  <thead>
    <tr>
      <th>Action</th>
      <th>Description</th>
      <th>Default</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>create</td>
      <td>
        Sets the global version of Ruby to be used in all shells. See 3.1
        rbenv global<sup>(1)</sup> for more details.
      </td>
      <td>Yes</td>
    </tr>
  </tbody>
</table>

1. [3.1 rbenv global][rbenv_3_1]

#### <a name="lwrps-rg-attributes"></a> Attributes

<table>
  <thead>
    <tr>
      <th>Attribute</th>
      <th>Description</th>
      <th>Default Value</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>rbenv_version</td>
      <td>
        <b>Name attribute:</b> a version of Ruby being managed by rbenv.
        <b>Note:</b> the version of Ruby must already be installed--this LWRP
        will not install it automatically.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>user</td>
      <td>
        A users's isolated rbenv installation on which to apply an action. The
        default value of <code>nil</code> denotes a system-wide rbenv
        installation is being targeted. <b>Note:</b> if specified, the user
        must already exist.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>root_path</td>
      <td>
        The path prefix to rbenv installation, for example:
        <code>/opt/rbenv</code>.
      </td>
      <td><code>nil</code></td>
    </tr>
  </tbody>
</table>

#### <a name="lwrps-rg-examples"></a> Examples

##### Set A Ruby As Global

    rbenv_global "1.8.7-p352"

##### Set System Ruby As Global

    rbenv_global "system"

##### Set A Ruby As Global For A User

    rbenv_global "jruby-1.7.0-dev" do
      user "tflowers"
    end

### <a name="lwrps-rsc"></a> rbenv_script

This resource is a wrapper for the `script` resource which wraps the code block
in an rbenv-aware environment. See the Opscode
[script resource][script_resource] page and the [rbenv shell][rbenv_3_3]
documentation for more details.

#### <a name="lwrps-rsc-actions"></a> Actions

<table>
  <thead>
    <tr>
      <th>Action</th>
      <th>Description</th>
      <th>Default</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>run</td>
      <td>Run the script</td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>nothing</td>
      <td>Do not run this command</td>
      <td>&nbsp;</td>
    </tr>
  </tbody>
</table>

Use `action :nothing` to set a command to only run if another resource
notifies it.

#### <a name="lwrps-rsc-attributes"></a> Attributes

<table>
  <thead>
    <tr>
      <th>Attribute</th>
      <th>Description</th>
      <th>Default Value</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>name</td>
      <td>
        <b>Name attribute:</b> Name of the command to execute.
      </td>
      <td>name</td>
    </tr>
    <tr>
      <td>rbenv_version</td>
      <td>
        A version of Ruby being managed by rbenv.
      </td>
      <td><code>"global"</code></td>
    </tr>
    <tr>
      <td>root_path</td>
      <td>
        The path prefix to rbenv installation, for example:
        <code>/opt/rbenv</code>.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>code</td>
      <td>
        Quoted script of code to execute.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>creates</td>
      <td>
        A file this command creates - if the file exists, the command will not
        be run.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>cwd</td>
      <td>
        Current working director to run the command from.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>environment</td>
      <td>
        A has of environment variables to set before running this command.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>group</td>
      <td>
        A group or group ID that we should change to before running this
        command.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>path</td>
      <td>
        An array of paths to use when searching for the command.
      </td>
      <td><code>nil</code>, uses system path</td>
    </tr>
    <tr>
      <td>returns</td>
      <td>
        The return value of the command (may be an array of accepted values) -
        this resource raises an exception if the return value(s) do not match.
      </td>
      <td><code>0</code></td>
    </tr>
    <tr>
      <td>timeout</td>
      <td>
        How many seconds to let the command run before timing out.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>user</td>
      <td>
        A users's isolated rbenv installation on which to apply an action. The
        default value of <code>nil</code> denotes a system-wide rbenv
        installation is being targeted. <b>Note:</b> if specified, the user
        must already exist.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>umask</td>
      <td>
        Umask for files created by the command.
      </td>
      <td><code>nil</code></td>
    </tr>
  </tbody>
</table>

#### <a name="lwrps-rsc-examples"></a> Examples

##### Run A Rake Task

    rbenv_script "migrate_rails_database" do
      rbenv_version "1.8.7-p352"
      user          "deploy"
      group         "deploy"
      cwd           "/srv/webapp/current"
      code          %{rake RAILS_ENV=production db:migrate}
    end

### <a name="lwrps-rbgem"></a> rbenv_gem

This resource is a close analog of the `gem_package` resource/provider which
is rbenv-aware. See the Opscode [package resource][package_resource] and
[gem package options][gem_package_options] pages for more details.

#### <a name="lwrps-rbgem-actions"></a> Actions

<table>
  <thead>
    <tr>
      <th>Action</th>
      <th>Description</th>
      <th>Default</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>install</td>
      <td>
        Install a gem - if version is provided, install that specific version.
      </td>
      <td>Yes</td>
    </tr>
    <tr>
      <td><upgrade/td>
      <td>
        Upgrade a gem - if version is provided, upgrade to that specific
        version.
      </td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>remove</td>
      <td>
        Remove a gem.
      </td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>purge</td>
      <td>
        Purge a gem.
      </td>
      <td>&nbsp;</td>
    </tr>
  </tbody>
</table>

#### <a name="lwrps-rbr-attributes"></a> Attributes

<table>
  <thead>
    <tr>
      <th>Attribute</th>
      <th>Description</th>
      <th>Default Value</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>package_name</td>
      <td>
        <b>Name attribute:</b> the name of the gem to install.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>rbenv_version</td>
      <td>
        A version of Ruby being managed by rbenv.
      </td>
      <td><code>"global"</code></td>
    </tr>
    <tr>
      <td>root_path</td>
      <td>
        The path prefix to rbenv installation, for example:
        <code>/opt/rbenv</code>.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>version</td>
      <td>
        The specific version of the gem to install/upgrade.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>options</td>
      <td>
        Add additional options to the underlying gem command.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>source</td>
      <td>
        Provide an additional source for gem providers (such as RubyGems).
        This can also include a file system path to a <code>.gem</code> file
        such as <code>/tmp/json-1.5.1.gem</code>.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>user</td>
      <td>
        A users's isolated rbenv installation on which to apply an action. The
        default value of <code>nil</code> denotes a system-wide rbenv
        installation is being targeted. <b>Note:</b> if specified, the user
        must already exist.
      </td>
      <td><code>nil</code></td>
    </tr>
  </tbody>
</table>

#### <a name="lwrps-rbgem-examples"></a> Examples

##### Install A Gem

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

**Note:** the install action is default, so the second example is a more common
usage.

##### Install A Gem From A Local File

    rbenv_gem "json" do
      rbenv_version   "ree-1.8.7-2011.03"
      source          "/tmp/json-1.5.1.gem"
      version         "1.5.1"
    end

##### Keep A Gem Up To Date

    rbenv_gem "homesick" do
      action :upgrade
    end

**Note:** the global rbenv Ruby will be targeted if no `rbenv_version` attribute
is given.

##### Remove A Gem

    rbenv_gem "nokogiri" do
      rbenv_version   "jruby-1.5.6"
      version         "1.4.4.2"
      action          :remove
    end

### <a name="lwrps-rrh"></a> rbenv_rehash

This resource installs shims for all Ruby binaries known to rbenv, as per
the [rbenv rehash docs][rbenv_3_6].

#### <a name="lwrps-rrh-actions"></a> Actions

<table>
  <thead>
    <tr>
      <th>Action</th>
      <th>Description</th>
      <th>Default</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>run</td>
      <td>Run the script</td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>nothing</td>
      <td>Do not run this command</td>
      <td>&nbsp;</td>
    </tr>
  </tbody>
</table>

Use `action :nothing` to set a command to only run if another resource
notifies it.

#### <a name="lwrps-rrh-attributes"></a> Attributes

<table>
  <thead>
    <tr>
      <th>Attribute</th>
      <th>Description</th>
      <th>Default Value</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>name</td>
      <td>
        <b>Name attribute:</b> Name of the command to execute.
      </td>
      <td>name</td>
    </tr>
    <tr>
      <td>user</td>
      <td>
        A users's isolated rbenv installation on which to apply an action. The
        default value of <code>nil</code> denotes a system-wide rbenv
        installation is being targeted. <b>Note:</b> if specified, the user
        must already exist.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>root_path</td>
      <td>
        The path prefix to rbenv installation, for example:
        <code>/opt/rbenv</code>.
      </td>
      <td><code>nil</code></td>
    </tr>
  </tbody>
</table>

#### <a name="lwrps-rrh-examples"></a> Examples

##### Rehash A System-Wide rbenv

    rbenv_rehash "Doing the rehash dance"

##### Rehash A User's rbenv

    rbenv_rehash "Rehashing tflowers' rbenv" do
      user  "tflowers"
    end

### <a name="lwrps-rbr"></a> rbenv_ruby

This resource uses the [ruby-build][ruby_build_site] framework to build and install
Ruby versions from definition files.

**Note:** this LWRP requires the [ruby\_build cookbook][ruby_build_cb] to be
in the run list to perform the builds.

#### <a name="lwrps-rbr-actions"></a> Actions

<table>
  <thead>
    <tr>
      <th>Action</th>
      <th>Description</th>
      <th>Default</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>install</td>
      <td>
        Build and install a Ruby from a definition file. See the ruby-build
        readme<sup>(1)</sup> for more details.
      </td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>reinstall</td>
      <td>
        Force a recompiliation of the Ruby from source. The :install action
        will skip a build if the target install directory already exists.
      </td>
      <td>&nbsp;</td>
    </tr>
  </tbody>
</table>

1. [ruby-build readme][rb_readme]

#### <a name="lwrps-rbr-attributes"></a> Attributes

<table>
  <thead>
    <tr>
      <th>Attribute</th>
      <th>Description</th>
      <th>Default Value</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>definition</td>
      <td>
        <b>Name attribute:</b> the name of a built-in definition<sup>(1)</sup>
        or the path to a ruby-build definition file.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>user</td>
      <td>
        A users's isolated rbenv installation on which to apply an action. The
        default value of <code>nil</code> denotes a system-wide rbenv
        installation is being targeted. <b>Note:</b> if specified, the user
        must already exist.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>root_path</td>
      <td>
        The path prefix to rbenv installation, for example:
        <code>/opt/rbenv</code>.
      </td>
      <td><code>nil</code></td>
    </tr>
  </tbody>
</table>

1. [built-in definition][rb_definitions]

#### <a name="lwrps-rbr-examples"></a> Examples

##### Install Ruby From ruby-build

    rbenv_ruby "ree-1.8.7-2011.03" do
      action :install
    end

    rbenv_ruby "jruby-1.6.5"

**Note:** the install action is default, so the second example is a more common
usage.

##### Reinstall Ruby

    rbenv_ruby "ree-1.8.7-2011.03" do
      action :reinstall
    end

## <a name="development"></a> Development

* Source hosted at [GitHub][repo]
* Report issues/Questions/Feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every separate change you make.

## <a name="license"></a> License and Author

Author:: Fletcher Nichol (<fnichol@nichol.ca>)

Copyright 2011, Fletcher Nichol

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[chef_repo]:        https://github.com/opscode/chef-repo
[cheffile]:         https://github.com/applicationsonline/librarian/blob/master/lib/librarian/chef/templates/Cheffile
[gem_package_options]: http://wiki.opscode.com/display/chef/Resources#Resources-GemPackageOptions
[kgc]:              https://github.com/websterclay/knife-github-cookbooks#readme
[librarian]:        https://github.com/applicationsonline/librarian#readme
[lwrp]:             http://wiki.opscode.com/display/chef/Lightweight+Resources+and+Providers+%28LWRP%29
[package_resource]: http://wiki.opscode.com/display/chef/Resources#Resources-Package
[rb_readme]:        https://github.com/sstephenson/ruby-build#readme
[rb_definitions]:   https://github.com/sstephenson/ruby-build/tree/master/share/ruby-build
[rbenv_site]:       https://github.com/sstephenson/rbenv
[rbenv_3_1]:        https://github.com/sstephenson/rbenv#section_3.1
[rbenv_3_3]:        https://github.com/sstephenson/rbenv#section_3.3
[rbenv_3_6]:        https://github.com/sstephenson/rbenv#section_3.6
[ruby_build_cb]:    http://community.opscode.com/cookbooks/ruby_build
[ruby_build_site]:  https://github.com/sstephenson/ruby-build
[script_resource]:  http://wiki.opscode.com/display/chef/Resources#Resources-Script

[repo]:         https://github.com/fnichol/chef-rbenv
[issues]:       https://github.com/fnichol/chef-rbenv/issues
