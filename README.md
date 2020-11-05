# Chef ruby_rbenv Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/ruby_rbenv.svg)](https://supermarket.chef.io/cookbooks/ruby_rbenv)
[![CircleCI Status](https://img.shields.io/circleci/project/github/sous-chefs/ruby_rbenv/master.svg)](https://circleci.com/gh/sous-chefs/ruby_rbenv/tree/master)

## Description

Manages [rbenv][rbenv_site] and its installed Rubies.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

### Chef

This cookbook requires Chef 13.0+.

**NOTE:** Some Chef versions (>= 16 and < 16.4.41) have a bug in the git resource causing some failures (see [#289](https://github.com/sous-chefs/ruby_rbenv/issues/289)). If you experience any troubles please try a more recent version of Chef 16.

### Platform

- Debian derivatives
- Fedora
- macOS (not currently tested)
- RHEL derivatives (RHEL, CentOS, Amazon Linux, Oracle, Scientific Linux)
- openSUSE and openSUSE leap

## Usage

Example installations are provided in `test/fixtures/cookbooks/test/recipes/`.

A `rbenv_system_install` or `rbenv_user_install` is required to be set so that rbenv knows which version you want to use, and is installed on the system.

System wide installations of rbenv are supported by this cookbook, but discouraged by the rbenv maintainer, see [these][rbenv_issue_38] [two][rbenv_issue_306] issues in the rbenv repository.

## Gem

Used to install a gem into the selected rbenv environment.

```ruby
rbenv_gem 'gem_name' do
  options # Optional: Options to pass to the gem command e.g. '--no-rdoc --no-ri'
  source # Optional: source URL/location for gem.
  timeout # Optional: Gem install timeout
  version # Optional: Gem version to install
  response_file # Optional: response file to reconfigure a gem
  rbenv_version # Required: Which rbenv version to install the gem to.
  user # Which user to install gem to. REQUIRED if you're using rbenv_user_install
end
```

## Global

Sets the global ruby version. The name of the resource is the version to set.

```ruby
rbenv_global '2.5.1' do
  user # Optional: if passed sets the users global version. Leave unset, to set the system global version
end
```

If a user is passed in to this resource it sets the global version for the user, under the users `root_path` (usually `~/.rbenv/version`), otherwise it sets the system global version.

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

If user is passed in, the user Ruby is rehashed rather than the system Ruby.

## Ruby

Installs a given Ruby version to the system or user location.

```ruby
rbenv_ruby '2.5.1' do
  user # Optional, but recommended: If passed, the user to install rbenv to
  rbenv_action # Optional: the action to perform, 'install' (default), 'uninstall' etc
end
```

Shorter example `rbenv_ruby '2.5.1'`

## Script

Runs a rbenv aware script.

```ruby
rbenv_script 'foo' do
  rbenv_version #rbenv version to run the script against
  environment # Optional: A Hash of environment variables in the form of ({"ENV_VARIABLE" => "VALUE"}).
  user # Optional: User to run as
  group # Optional: Group to run as
  returns # Optional: Expected return code
  code # Script code to run
end
```

Note that environment overwrites the entire variable.
For example. setting the `$PATH` variable can be done like this:

```ruby
rbenv_script 'bundle package' do
  cwd node["bundle_dir"]
  environment ({"PATH" => "/usr/local/rbenv/shims:/usr/local/rbenv/bin:#{ENV["PATH"]}"})
  code "bundle package --all"
end
```

Where `#{ENV["PATH"]}` appends the existing PATH to the end of the newly set PATH.

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

## System-Wide macOS Installation Note

This cookbook takes advantage of managing profile fragments in an `/etc/profile.d` directory, common on most Unix-flavored platforms. Unfortunately, macOS does not support this idiom out of the box, so you may need to [modify][mac_profile_d] your user profile.

## Development

- Source hosted at [GitHub][repo]
- Report issues/Questions/Feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

```text
http://www.apache.org/licenses/LICENSE-2.0
```

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
