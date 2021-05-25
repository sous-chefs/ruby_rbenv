# Gem

Used to install a gem into the selected rbenv environment.

## Properties

| Name                   | Type              | Default              | Description |
| ---------------------- | ----------------- | -------------------- | ----------- |
| clear_sources          |                   | `true, false`        |             |
| include_default_source | `true', 'false`   | `true`               |             |
| ignore_failure         | `true', 'false`   | `false`              |             |
| options                | `String`, `Hash`  |                      |             |
| package_name           | `String`, `Array` |                      |             |
| source                 | `String`, `Array` |                      |             |
| timeout                | `Integer`         | 300                  |             |
| version                | `String`          |                      |             |
| response_file          | `String`          |                      |             |
| user                   | `String`          |                      |             |
| rbenv_version          | `String`          |                      |             |
| root_path              | `String`          | See root_path helper |             |

## Examples

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
