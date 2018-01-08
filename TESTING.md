# Testing

## Pre-requisites

- [chefdk](https://downloads.chef.io/chefdk/current)

## New Features or Bug Fixes

All new features of bug fixes should come with testing if possible.

If you are unsure how to write the integration tests the #sous-chefs channel on the chef community slack will be more than happy to provide help.

## Testing

Integration testing with kitchen.

- Simply run kitchen test `<platform>` to get the current state of testing.

If the test case if not already covered

- Add a suite to `kitchen.yml`
- Add an inspec suite see examples in `test/integration/user_install`
- Add the suite to `travis.yml`
