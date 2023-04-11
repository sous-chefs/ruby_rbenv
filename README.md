# Chef ruby_rbenv Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/ruby_rbenv.svg)](https://supermarket.chef.io/cookbooks/ruby_rbenv)
[![CI State](https://github.com/sous-chefs/ruby_rbenv/workflows/ci/badge.svg)](https://github.com/sous-chefs/ruby_rbenv/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

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

## Resources

- [rbenv_gem](documentation/resources/rbenv_gem.md)
- [rbenv_global](documentation/resources/rbenv_global.md)
- [rbenv_plugin](documentation/resources/rbenv_plugin.md)
- [rbenv_rehash](documentation/resources/rbenv_rehash.md)
- [rbenv_ruby](documentation/resources/rbenv_ruby.md)
- [rbenv_script](documentation/resources/rbenv_script.md)
- [rbenv_system_install](documentation/resources/rbenv_system_install.md)
- [rbenv_user_install](documentation/resources/rbenv_user_install.md)

## Usage

Example installations are provided in `test/fixtures/cookbooks/test/recipes/`.

A `rbenv_system_install` or `rbenv_user_install` is required to be set so that rbenv knows which version you want to use, and is installed on the system.

System wide installations of rbenv are supported by this cookbook, but discouraged by the rbenv maintainer, see [these][rbenv_issue_38] [two][rbenv_issue_306] issues in the rbenv repository.

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
