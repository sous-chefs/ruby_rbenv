# Gem

Used to install a gem into the selected rbenv environment.

## Properties

| Name                   | Type              | Default              | Description                                |
| ---------------------- | ----------------- | -------------------- | ------------------------------------------ |
| clear_sources          | `true', 'false`   | `true, false`        |                                            |
| include_default_source | `true', 'false`   | `true`               |                                            |
| ignore_failure         | `true', 'false`   | `false`              |                                            |
| options                | `String`, `Hash`  |                      | Options to pass to the gem command.        |
| package_name           | `String`, `Array` |                      |                                            |
| source                 | `String`, `Array` |                      | Source URL/location for gem.               |
| timeout                | `Integer`         | `300`                | Gem install timeout.                       |
| version                | `String`          |                      | Gem version to install.                    |
| response_file          | `String`          |                      | Response file to reconfigure a gem.        |
| user                   | `String`          |                      | Which user to install gem to.              |
| rbenv_version          | `String`          |                      | Which rbenv version to install the gem to. |
| root_path              | `String`          | See root_path helper |                                            |

## Example

```ruby
rbenv_gem 'gem_name' do
  user 'vagrant'
end
```
