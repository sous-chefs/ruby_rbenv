# [Unreleased]

- added checks to user install recipes to avoid breaking if the rbenv_home does not exist

# 1.1.0 (July 17, 2016)

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

# 1.0.1 (October 24, 2015)

- Fixed failure with rehashing after the cookbook was renamed

# 1.0.0 (October 12, 2015)

## WARNING: Cookbook has been renamed

- Renamed to ruby_rbenv and uploaded to Supermarket (all attributes rename in the rbenv cookbook). If you wrap this cookbook you're going to need to update the recipes you include. All providers have been updated to keep their existing rbenv_xyz names for backwards compatibility and attributes still maintain the rbenv namespace.
- Updated Travis config to run integration tests in Travis using kitchen-docker

# 0.9.0 (October 12, 2015)

- Fixed base platform case statement in the cookbook that set install_pkgs and user_home_root attributes. This has been converted to a platform_family statement to better support derivitive operating systems and the attributes are set at default levels so they can be overwritten in wrapper cookbooks
- Updated Travis to test using Chef DK vs. Gem installs
- Fixed Chefspecs and Test Kitchen bats tests to all pass
- Added the Apache 2.0 license file
- Updated and added new development dependencies to the Gemfile
- Use Chef 12.1+ multi-package installs for the dependency packages to speed up installs
- Removed the empty Vagrant recipe
- Actually depend on ruby_version vs. suggests since suggests isn't implemented in Chef

# 0.8.1 (August 28, 2015)

- Add rbenv_action attribute to rbenv_ruby LWRP so to allow using rvm-download rbenv plugin to download ruby vs. installing ruby
- Fix the ability to install gems to a specific version of ruby
- Remove Chef version checks around use_inline_resources since we require Chef 12
- Use default_action method in the LWRPs
- Fix various rubocop warnings

# 0.8.0 (July 27, 2015)

- Drop support for Chef versions prior to 12
- Add Arch linux support
- Add Linux mint support

# 0.7.3 (July 8, 2015)

## Bug Fixes

- Issue [#91](https://github.com/fnichol/chef-rbenv/issues/91) [#79](https://github.com/fnichol/chef-rbenv/issues/79) [#92](https://github.com/fnichol/chef-rbenv/pull/92): Add matchers for rbenv_gem and rbenv_ruby. ([@tduffield](https://github.com/tduffield) and many others)
- Issue [#107](https://github.com/fnichol/chef-rbenv/issues/107): "Option name must be a kind of String!" when installing gems.
- Issue [#101](https://github.com/fnichol/chef-rbenv/issues/101): Use full class name for rbenv_rehash resource
- Fix undefined method `timeout' for LWRP resource rbenv_gem. ([@nathantsoi](https://github.com/nathantsoi) and others)
- Issue [#110](https://github.com/fnichol/chef-rbenv/issues/110): Chef 12.3.0 - undefined method `clear_sources' for Chef::Resource::RbenvGem. ([@tatat](https://github.com/tatat) and others)

## Improvements

- Fork from <https://github.com/fnichol/chef-rbenv>

# 0.7.2 (December 31, 2012)

## Bug Fixes

- Pull request [#26](https://github.com/fnichol/chef-rbenv/pull/26): Don't call libexec commands directly. ([@mhoran])

## Improvements

- Add integration tests for a system Ruby version. ([@fnichol])

# 0.7.1 (unreleased)

## Bug Fixes

- Pull request [#36](https://github.com/fnichol/chef-rbenv/pull/36): Use the ruby name as the definition to install ([@gsandie])
- Pull request [#55](https://github.com/fnichol/chef-rbenv/pull/55): Fix some CHEF-3694 warnings when using with ruby_build ([@trinitronx])

## New features

- Pull request [#26](https://github.com/fnichol/chef-rbenv/pull/26): Allow setting environment vars per ruby install ([@jasherai])
- Pull request [#37](https://github.com/fnichol/chef-rbenv/pull/37): Allows use `include_recipe("ruby_build")` instead of having to put it in the `run_list` ([@tjwallace])
- Pull request [#42](https://github.com/fnichol/chef-rbenv/pull/42): Load rbenv environment after install ([@msaffitz])
- Pull request [#62](https://github.com/fnichol/chef-rbenv/pull/62): Add Gentoo as supported platform ([@gentooboontoo])

## Improvements

- Pull request [#46](https://github.com/fnichol/chef-rbenv/pull/46): Add a `definition_file` attribute to the `rbenv_ruby` resource to prevent continually trying to build a custom ruby when passed a build file name instead of a built-in definition ([@jf647])
- Pull request [#60](https://github.com/fnichol/chef-rbenv/pull/60): Support `definition_file` in rubies definition ([@cyu])
- Pull request [#75](https://github.com/fnichol/chef-rbenv/pull/75): Update testing support and add unit tests for existing resources ([@fnichol])
- Pull request [#70](https://github.com/fnichol/chef-rbenv/pull/70): Support ruby 2.1.0 ([@WhyEee])

# 0.7.0 (November 21, 2012)

## Bug Fixes

- Issue [#14](https://github.com/fnichol/chef-rbenv/pull/14): Create /etc/profile.d on system-wide and add note for Mac. ([@fnichol])

## New features

- Pull request [#20](https://github.com/fnichol/chef-rbenv/pull/20): Set an attribute to create profile.d for user install. ([@jtimberman])

## Improvements

- Pull request [#12](https://github.com/fnichol/chef-rbenv/pull/12): Add name attribute to metadata. ([@jtimberman])
- Update foodcritic configuration and update .travis.yml. ([@fnichol])
- Update Installation section of README (welcome Berkshelf). ([@fnichol])

# 0.6.10 (May 18, 2012)

## New features

- Pull request [#11](https://github.com/fnichol/chef-rbenv/pull/11): Add FreeBSD support. ([@jssjr])

## Improvements

- Add other platform supports in metadata.rb and README. ([@fnichol])

# 0.6.8 (May 6, 2012)

## Improvements

- Add official hook resource log[rbenv-post-init-*] for inter-cookbook integration. ([@fnichol])

# 0.6.6 (May 4, 2012)

## Bug Fixes

- Fix FC022: Resource condition within loop may not behave as expected. ([@fnichol])
- Add plaform equivalents in default attrs (FC024). ([@fnichol])
- Ensure update-java-alternatives is called before JRuby is built. ([@fnichol])
- Pull request [#8](https://github.com/fnichol/chef-rbenv/pull/8): Add /etc/profile.d/rbenv.sh support for user installs. ([@thoughtless])

## Improvements

- Add TravisCI to run Foodcritic linter. ([@fnichol])
- Pull request [#10](https://github.com/fnichol/chef-rbenv/pull/10): README proofreading. ([@jdsiegel])
- README updates. ([@fnichol])
- Confirm debian platform support. ([@fnichol])

# 0.6.4 (February 23, 2012)

## Bug Fixes

- Set `root_path` on rbenv_rehash in rbenv_gem provider. ([@fnichol])

## Improvements

- Foodcritic lint-driven code updates. ([@fnichol])
- Update Git URL in README. ([@hedgehog])

# 0.6.2 (February 22, 2012)

## Bug Fixes

- Issues [#1](https://github.com/fnichol/chef-rbenv/issues/1), [#2](https://github.com/fnichol/chef-rbenv/issues/2): Stub mixins in RbenvRubygems to avoid libraries load ordering issues. ([@fnichol])
- Pull request [#5](https://github.com/fnichol/chef-rbenv/pull/5): Include user setting in rehash calls. ([@magnetised])
- Issue [#4](https://github.com/fnichol/chef-rbenv/issues/4): Fix rbenv/gems hash parsing. ([@fnichol])

## Improvements

- Large formatting updates to README. ([@fnichol])
- Add gh-pages branch for sectioned README at <https://fnichol.github.com/chef-rbenv>

# 0.6.0 (December 21, 2011)

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
