# Chef ruby_rbenv Cookbook

[![Build Status](https://travis-ci.org/sous-chefs/ruby_rbenv.svg?branch=master)](https://travis-ci.org/sous-chefs/ruby_rbenv) [![Cookbook Version](https://img.shields.io/cookbook/v/ruby_rbenv.svg)](https://supermarket.chef.io/cookbooks/ruby_rbenv)

## Description

Manages [rbenv][rbenv_site] and its installed Rubies.

Several custom_resources are defined facilitate this.

**WARNING**: As of version 1.0 this cookbook was renamed from rbenv to ruby_rbenv so it could be uploaded to the Supermarket.

## Requirements

### Chef

This cookbook requires Chef 12.9+.

### Platform

- Debian derivatives
- Fedora
- macOS
- RHEL derivatives (RHEL, CentOS, Amazon Linux, Oracle, Scientific Linux)
- openSUSE and openSUSE leap

# Usage

_Please read_

Example installations are provided in test/fixtures/cookbooks/test/recipes/

A `rbenv_system_install` or `rbenv_user_install` is required to be set so that rbenv knows which version you want to use, and is installed on the system.

## Gem

Used to install a gem into the selected rbenv environment.

```ruby
rbenv_gem 'gem_name' do
  options # Optional: Options to pass to the gem command e.g. '--no-rdoc --no-ri'
  source # Optional: source URL/location for gem.
  timeout # Optional: Gem install timeout
  version # Optional: Gem version to install
  response_file # Optional: response file to reconfigure a gem
  rbenv_version # Which rbenv verison to install the gem to. Defaults to global
end
```

## Global

```ruby
rbenv_global '2.3.4' do
  user # Optional: if passed sets the users global version. Do not set, to set the systems global version
end
```

If a user is passed in to this resource it sets the global version for the user, under the users root_path (usually `~/.rbenv/version`), otherwise it sets the system global version.

## Plugin

Installs a rbenv plugin.

```ruby
rbenv_plugin 'ruby-build' do
  git_url # Git URL of the plugin
  git_ref # Git reference of the plugin
  user # Optional: if passed installs to the users rbenv. Do not set, to set installs to the system rbenv.
end
```

If user is passed in, the plugin is installed to the users install of rbenv.

## Rehash

```ruby
rbenv_rehash 'rehash' do
  user 'vagrant' # Optional: if passed rehashes the user Ruby otherwise rehashes the system rbenv
end
```

## Ruby

Installs a given Ruby version to the system or user location.

```ruby
rbenv_ruby '2.3.4' do
  user # Optional: If passed the user rbenv to install to
  rbenv_action # Optional: the action to perform, install, remove etc
end
```

Shorter example `rbenv_ruby '2.4.1'`

## Script

Runs a rbenv aware script.

```ruby
rbenv_script 'foo' do
  rbenv_version #rbenv version to run the script against
  environment # Optional: Environment to setup to run the script
  user # Optional: User to run as
  group # Optional: Group to run as
  path # Optional: User to run as
  returns # Optional: Expected return code
  code # Script code to run
end
```

## System_install

Installs rbenv to the system location, by default `/usr/local/rbenv`

```ruby
rbenv_system_install 'foo' do
  git_url # URL of the plugin repo you want to checkout
  git_ref # Optional: Git reference to checkout
  update_rbenv # Optional: Keeps the git repo up to date
end
```

## User_install

Installs rbenv to the user path, making rbenv available to that user only.

```ruby
rbenv_user_install 'vagrant' do
  git_url # Optional: Git URL to checkout rbenv from.
  git_ref # Optional: Git reference to checkout e.g. 'master'
  user # Which user to install rbenv to (also specified in the resources name above)
end
```

## System-Wide Mac Installation Note

This cookbook takes advantage of managing profile fragments in an `/etc/profile.d` directory, common on most Unix-flavored platforms. Unfortunately, Mac OS X does not support this idiom out of the box, so you may need to [modify][mac_profile_d] your user profile.

## Development

- Source hosted at [GitHub][repo]
- Report issues/Questions/Feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.

## License and Author

- Author:: [Fletcher Nichol][fnichol] ([fnichol@nichol.ca](mailto:fnichol@nichol.ca))
- Author:: [Dan Webb][damacus]

Copyright 2011, Fletcher Nichol

Copyright 2017, Dan Webb

```
http://www.apache.org/licenses/LICENSE-2.0
```

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

[custom_resources]: https://docs.chef.io/custom_resources.html
[damacus]: https://github.com/damacus
[fnichol]: https://github.com/fnichol
[issues]: https://github.com/sous-chefs/ruby_rbenv/issues
[mac_profile_d]: http://hints.macworld.com/article.php?story=20011221192012445
[rb_readme]: https://github.com/sstephenson/ruby-build#readme
[rbenv_site]: https://github.com/sstephenson/rbenv
[repo]: https://github.com/sous-chefs/ruby_rbenv
[ruby_build_cb]: https://supermarket.chef.io/cookbooks/ruby_build
