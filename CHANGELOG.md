# Changelog

All notable changes to this project will be documented in this file.

## Unreleased

## 3.0.0 - *2020-11-26*

- Namespace the root_path variables to avoid naming conflicts with other sous-chef cookbooks.

## 2.6.0 - 2020-10-28

**NOTE:** Some Chef versions (>= 16 and < 16.4.41) have a bug in the git resource causing some failures (see [#289](https://github.com/sous-chefs/ruby_rbenv/issues/289)). If you experience any troubles please try a more recent version of Chef 16.

- Remove workaround for chef bug in git resource (fixes #289)

## 2.5.1 - 2020-08-20

- Add placeholder for spec directory to tests run properly
- Fix InSpec tests
- Fix Ubuntu 18.04 dependency: libssl-dev

## 2.5.0 - 2020-07-24

- Add support for Ubuntu 20.04
- Fix dependancy issue for suse

## 2.3.2 - 2020-05-05

- Migrate to actions for testing

## [2.3.1] - 2019-12-17

- Remove the unnecessary long_metadata value in metadata.rb
- Fix Debian 10 dependency: libgdm6
- Use TrueClass and FalseClass in resources

## [2.3.0] - 2019-09-30

- Allow to specify the root_path so global rbenv install can run rbenv_scripts as non root (#247)

## [2.2.0] - 2019-08-08

- Use CircleCI 2.0 Orb

## [2.1.3] - 2019-07-17

- Update CircleCI testing orb
- Update platforms, remove Debian 8 testing support

## [2.1.2] - 2018-11-09

- Fix `TypeError: no implicit conversion of nil into String` for `mac_os_x` platforms

## [2.1.1] - 2018-10-08

- Fixed `rbenv_action` to support actions like `uninstall` (#189)

## [2.1.0] - 2018-08-28

- Drop support for Chef 12

## [2.0.9] - 2018-06-12

- Fix verbose option (#220)

## [2.0.8] - 2018-06-09

- Install the git package rather than the git-core package (#217)

## [2.0.7] - 2018-03-11

- Adding Ubuntu 18.04 support
- Move all helpers into the helper file
- Remove rubinius support, that never worked anyway.

## [2.0.6] - 2018-01-08

- Fix rubinius install
- Add tests for rubinius

## [2.0.5] - 2017-10-17

- Add missing jruby deps #191
- Update README for general usage

## [2.0.4] - 2017-08-17

- Group support on user install #183

## [2.0.3] - 2017-08-04

- Fix rehash resource #179

## [2.0.2] - 2017-08-02

- Fix gem_install resource so it can install gems to a non-global ruby gem.

## [2.0.1] - 2017-08-02

- Fix user_install resource bug where the script wasn't being called with the correct environment. Fixes #175

## [2.0.0] - 2017-07-24

- Switch libraries to custom resources
- Use gem install from core Chef
- Add rbenv_system_install resource
- Remove system_install recipe. Please see the system_install test recipe for usage.
- Remove user_install recipe. Please see the user_install test recipe for usage.
- Removed all other recipes for consistent usage.
- Remove FreeBSD "support" (the platform isn't currently tested)
- Remove Arch Linux support in README. We never really supported this, and it isn't tested
- Update required chef-version to the one we test with (Chef 12.19+)

### Known Current Bugs

- Installing Ruby 2.3.1 on Fedora requires a patched version of 2.3.1\. As patching is currently unavailable please pin to a prior version if you need this installing.

## [1.2.1] - 2017-06-23

- Fixed resource failures on Chef 13
- Updated the Apache license string to a SPDX compliant string
- Added Travis testing for Chef 12 and 13
- Switched testing from Rake to local delivery

## [1.2.0] - 2017-04-11

- Migrated maintenance of this cookbook to Sous Chefs
- Remove the check to see if the homebrew provider exists since this always exists in Chef 12 and the code failed on Chef 13
- Added checks to user install recipes to avoid breaking if the rbenv_home does not exist
- Removed test deps from the Gemfile as we should be testing with ChefDK
- Removed the "suggests 'java'" metadata as suggests was never implemented in Chef and has been removed from Chef 13
- Bumped the required Chef release from 12.0 to 12.1

## [1.1.0] - 2016-06-17

- Restored compatibility for platforms that don't yet support multipackage installs in Chef (BSD and OS X in particular)
- Updated to Grab rbenv from the new repo URL and use https vs. git for compatibility
- Added missing Chefspec matchers
- Enabled use_inline_resources in all providers
- Added chef_version metadata to metadata.rb
- Added source_url and issues_url metadata to metadata.rb
- Added bash a depedency for FreeBSD
- Switched Travis testing to Kitchen Dokken
- Added a chefignore file to limit the files uploaded to the chef server
- Switched linting from Rubocop to Cookstyle (rubocop wrapper by Chef)

## [1.0.1] - 2015-10-24

- Fixed failure with rehashing after the cookbook was renamed

## [1.0.0] - 2015-10-12

### WARNING: Cookbook has been renamed

- Renamed to ruby_rbenv and uploaded to Supermarket (all attributes rename in the rbenv cookbook). If you wrap this cookbook you're going to need to update the recipes you include. All providers have been updated to keep their existing rbenv_xyz names for backwards compatibility and attributes still maintain the rbenv namespace.
- Updated Travis config to run integration tests in Travis using kitchen-docker

## [0.9.0] - 2015-10-12

- Fixed base platform case statement in the cookbook that set install_pkgs and user_home_root attributes. This has been converted to a platform_family statement to better support derivitive operating systems and the attributes are set at default levels so they can be overwritten in wrapper cookbooks
- Updated Travis to test using Chef DK vs. Gem installs
- Fixed Chefspecs and Test Kitchen bats tests to all pass
- Added the Apache 2.0 license file
- Updated and added new development dependencies to the Gemfile
- Use Chef 12.1+ multi-package installs for the dependency packages to speed up installs
- Removed the empty Vagrant recipe
- Actually depend on ruby_version vs. suggests since suggests isn't implemented in Chef

## [0.8.1] - 2015-08-28

- Add rbenv_action attribute to rbenv_ruby LWRP so to allow using rvm-download rbenv plugin to download ruby vs. installing ruby
- Fix the ability to install gems to a specific version of ruby
- Remove Chef version checks around use_inline_resources since we require Chef 12
- Use default_action method in the LWRPs
- Fix various rubocop warnings

## [0.8.0] - 2015-07-27

- Drop support for Chef versions prior to 12
- Add Arch linux support
- Add Linux mint support

## [0.7.3] - (2015-07-8)

- Issue [#91](https://github.com/fnichol/chef-rbenv/issues/91) [#79](https://github.com/fnichol/chef-rbenv/issues/79) [#92](https://github.com/fnichol/chef-rbenv/pull/92): Add matchers for rbenv_gem and rbenv_ruby. ([@tduffield](https://github.com/tduffield) and many others)
- Issue [#107](https://github.com/fnichol/chef-rbenv/issues/107): "Option name must be a kind of String!" when installing gems.
- Issue [#101](https://github.com/fnichol/chef-rbenv/issues/101): Use full class name for rbenv_rehash resource
- Fix undefined method `timeout' for LWRP resource rbenv_gem. ([@nathantsoi](https://github.com/nathantsoi) and others)
- Issue [#110](https://github.com/fnichol/chef-rbenv/issues/110): Chef 12.3.0 - undefined method `clear_sources' for Chef::Resource::RbenvGem. ([@tatat](https://github.com/tatat) and others)
- Fork from <https://github.com/fnichol/chef-rbenv>

## [0.7.2] - 2012-12-31

- Pull request [#26](https://github.com/fnichol/chef-rbenv/pull/26): Don't call libexec commands directly. ([@mhoran])
- Add integration tests for a system Ruby version. ([@fnichol])
- Pull request [#36](https://github.com/fnichol/chef-rbenv/pull/36): Use the ruby name as the definition to install ([@gsandie])
- Pull request [#55](https://github.com/fnichol/chef-rbenv/pull/55): Fix some CHEF-3694 warnings when using with ruby_build ([@trinitronx])

### New features

- Pull request [#26](https://github.com/fnichol/chef-rbenv/pull/26): Allow setting environment vars per ruby install ([@jasherai])
- Pull request [#37](https://github.com/fnichol/chef-rbenv/pull/37): Allows use `include_recipe("ruby_build")` instead of having to put it in the `run_list` ([@tjwallace])
- Pull request [#42](https://github.com/fnichol/chef-rbenv/pull/42): Load rbenv environment after install ([@msaffitz])
- Pull request [#62](https://github.com/fnichol/chef-rbenv/pull/62): Add Gentoo as supported platform ([@gentooboontoo])
- Pull request [#46](https://github.com/fnichol/chef-rbenv/pull/46): Add a `definition_file` attribute to the `rbenv_ruby` resource to prevent continually trying to build a custom ruby when passed a build file name instead of a built-in definition ([@jf647])
- Pull request [#60](https://github.com/fnichol/chef-rbenv/pull/60): Support `definition_file` in rubies definition ([@cyu])
- Pull request [#75](https://github.com/fnichol/chef-rbenv/pull/75): Update testing support and add unit tests for existing resources ([@fnichol])
- Pull request [#70](https://github.com/fnichol/chef-rbenv/pull/70): Support ruby 2.1.0 ([@WhyEee])

## [0.7.0] - 2012-11-21

- Issue [#14](https://github.com/fnichol/chef-rbenv/pull/14): Create /etc/profile.d on system-wide and add note for Mac. ([@fnichol])
- Pull request [#20](https://github.com/fnichol/chef-rbenv/pull/20): Set an attribute to create profile.d for user install. ([@jtimberman])
- Pull request [#12](https://github.com/fnichol/chef-rbenv/pull/12): Add name attribute to metadata. ([@jtimberman])
- Update foodcritic configuration and update .travis.yml. ([@fnichol])
- Update Installation section of README (welcome Berkshelf). ([@fnichol])

## [0.6.10] - 2012-05-18

- Pull request [#11](https://github.com/fnichol/chef-rbenv/pull/11): Add FreeBSD support. ([@jssjr])
- Add other platform supports in metadata.rb and README. ([@fnichol])

## [0.6.8] - 2012-05-06

- Add official hook resource `log[rbenv-post-init-*]` for inter-cookbook integration. ([@fnichol])

## [0.6.6] - 2012-05-04

- Fix FC022: Resource condition within loop may not behave as expected. ([@fnichol])
- Add plaform equivalents in default attrs (FC024). ([@fnichol])
- Ensure update-java-alternatives is called before JRuby is built. ([@fnichol])
- Pull request [#8](https://github.com/fnichol/chef-rbenv/pull/8): Add /etc/profile.d/rbenv.sh support for user installs. ([@thoughtless])
- Add TravisCI to run Foodcritic linter. ([@fnichol])
- Pull request [#10](https://github.com/fnichol/chef-rbenv/pull/10): README proofreading. ([@jdsiegel])
- README updates. ([@fnichol])
- Confirm debian platform support. ([@fnichol])

## [0.6.4] - 2012-02-23

- Set `root_path` on rbenv_rehash in rbenv_gem provider. ([@fnichol])
- Foodcritic lint-driven code updates. ([@fnichol])
- Update Git URL in README. ([@hedgehog])

## [0.6.2] - 2012-02-22

- Issues [#1](https://github.com/fnichol/chef-rbenv/issues/1), [#2](https://github.com/fnichol/chef-rbenv/issues/2): Stub mixins in RbenvRubygems to avoid libraries load ordering issues. ([@fnichol])
- Pull request [#5](https://github.com/fnichol/chef-rbenv/pull/5): Include user setting in rehash calls. ([@magnetised])
- Issue [#4](https://github.com/fnichol/chef-rbenv/issues/4): Fix rbenv/gems hash parsing. ([@fnichol])
- Large formatting updates to README. ([@fnichol])
- Add gh-pages branch for sectioned README at <https://fnichol.github.com/chef-rbenv>

## [0.6.0] - 2011-12-21

The initial release.

[@cyu]: https://github.com/cyu
[@fnichol]: https://github.com/fnichol
[@gentooboontoo]: https://github.com/gentooboontoo
[@gsandie]: https://github.com/gsandie
[@hedgehog]: https://github.com/hedgehog
[@jasherai]: https://github.com/jasherai
[@jdsiegel]: https://github.com/jdsiegel
[@jf647]: https://github.com/jf647
[@jssjr]: https://github.com/jssjr
[@jtimberman]: https://github.com/jtimberman
[@magnetised]: https://github.com/magnetised
[@mhoran]: https://github.com/mhoran
[@msaffitz]: https://github.com/msaffitz
[@thoughtless]: https://github.com/thoughtless
[@tjwallace]: https://github.com/tjwallace
[@trinitronx]: https://github.com/trinitronx
[@whyeee]: https://github.com/WhyEee
