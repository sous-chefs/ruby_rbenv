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

- Debian derivatives (Debian 7+, Ubuntu 12.04+, Linux Mint)
- Fedora
- macOS
- RHEL derivatives (RHEL, CentOS, Amazon Linux, Oracle, Scientific Linux)

This cookbook requires Chef 12.1+.

### Cookbooks

- [ruby_build cookbook][ruby_build_cb]
- java cookbook if installing jruby (recommended, but not required in the metadata)

# Usage

## Gem

Used to install a gem into the selected rbenv environment.

```ruby
rbenv_gem 'gem_name' do
  clear_sources, [true, false]
  include_default_source, [true, false]
  gem_binary, String
  options, [String, Hash]
  package_name, [String, Array], name_property: true
  source, [String, Array]
  timeout, [String, Integer], default: 300
  version, [String, Array]
  response_file, String # Only used to reconfig
  user, String
  root_path, String
  rbenv_version, String, default: 'global'
end
```

## Global

```ruby
rbenv_global '2.3.4' do
  rbenv_version, String, name_property: true
  user, String
end
```

If a user is passed in to this resource it sets the global version for the user, under the users root_path (usually `~/.rbenv/version`), otherwise it sets the system global version.

## Plugin

Installs a rbenv plugin.

```ruby
rbenv_plugin 'ruby-build' do
  git_url, String, required: true
  git_ref, String, default: 'master'
  user, String
end
```

If user is passed in, the plugin is installed to the users install of rbenv.

## Rehash

```ruby
rbenv_rehash 'rehash' do
  user, String
end
```

If user is passed in the user rbenv is rehashed.

## Ruby

Installs a given Ruby version to the system or user location.

```ruby
rbenv_ruby '2.3.4' do
  version, String, name_property: true
  version_file, String
  user, String
  environment, Hash
  rbenv_action, String, default: 'install'
end
```

Example `rbenv_ruby '2.4.1'`

## Script

Runs a rbenv aware script.

``ruby rbenv_script 'foo' do rbenv_version, String code, String creates, String cwd, String environment, Hash group, String path, Array returns, Array, default: [0] timeout, Integer user, String umask, [String, Integer] end

```` `

## System_install

Installs rbenv to the system location, by default `/usr/local/rbenv`

```ruby
rbenv_system_install ''
  git_url, String, default: 'https://github.com/rbenv/rbenv.git'
  git_ref, String, default: 'master'
  global_prefix, String, default: '/usr/local/rbenv'
  update_rbenv, [true, false] # Keeps the git repo up to date
````

## User_install

Installs rbenv to the user path, making rbenv available to that user only.

```ruby
rbenv_user_install 'vagrant' do
  git_url, String, default: 'https://github.com/rbenv/rbenv.git'
  git_ref, String, default: 'master'
  user, String, name_property: true
  home_dir, String, default: lazy { ::File.expand_path("~#{user}") }
  user_prefix, String, default: lazy { ::File.join(home_dir, '.rbenv') }
  update_rbenv, [true, false], default: true
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
[issues]: https://github.com/chef-rbenv/ruby-rbenv/issues
[mac_profile_d]: http://hints.macworld.com/article.php?story=20011221192012445
[rb_readme]: https://github.com/sstephenson/ruby-build#readme
[rbenv_site]: https://github.com/sstephenson/rbenv
[repo]: https://github.com/sous-chefs/ruby-rbenv
[ruby_build_cb]: https://supermarket.chef.io/cookbooks/ruby_build
