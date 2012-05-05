## 0.6.7 (unreleased)


## 0.6.6 (May 4, 2012)

### Bug Fixes

* Fix FC022: Resource condition within loop may not behave as expected. ([@fnichol][])
* Add plaform equivalents in default attrs (FC024). ([@fnichol][])
* Ensure update-java-alternatives is called before JRuby is built. ([@fnichol][])
* Pull request [#8](https://github.com/fnichol/chef-rbenv/pull/8): Add /etc/profile.d/rbenv.sh support for user installs. ([@thoughtless][])

### Improvements

* Add TravisCI to run Foodcritic linter. ([@fnichol][])
* Pull request [#10](https://github.com/fnichol/chef-rbenv/pull/10): README proofreading. ([@jdsiegel][])
* README updates. ([@fnichol][])
* Confirm debian platform support. ([@fnichol][])


## 0.6.4 (February 23, 2012)

### Bug Fixes

* Set `root_path` on rbenv\_rehash in rbenv\_gem provider. ([@fnichol][])

### Improvements

* Foodcritic lint-driven code updates. ([@fnichol][])
* Update Git URL in README. ([@hedgehog][])


## 0.6.2 (February 22, 2012)

### Bug Fixes

* Issues [#1](https://github.com/fnichol/chef-rbenv/issues/1), [#2](https://github.com/fnichol/chef-rbenv/issues/2): Stub mixins in RbenvRubygems to avoid libraries load ordering issues. ([@fnichol][])
* Pull request [#5](https://github.com/fnichol/chef-rbenv/pull/5): Include user setting in rehash calls. ([@magnetised][])
* Issue [#4](https://github.com/fnichol/chef-rbenv/issues/4): Fix rbenv/gems hash parsing. ([@fnichol][])

### Improvements

* Large formatting updates to README. ([@fnichol][])
* Add gh-pages branch for sectioned README at https://fnichol.github.com/chef-rbenv


## 0.6.0 (December 21, 2011)

The initial release.

[@fnichol]: https://github.com/fnichol
[@jdsiegel]: https://github.com/jdsiegel
[@hedgehog]: https://github.com/hedgehog
[@magnetised]: https://github.com/magnetised
[@thoughtless]: https://github.com/thoughtless
