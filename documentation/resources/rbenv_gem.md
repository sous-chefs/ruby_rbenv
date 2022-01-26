# Gem

Used to install a gem into the selected rbenv environment.

## Properties

| Name                   | Type              | Default              | Description                                                             |
| ---------------------- | ----------------- | -------------------- | ----------------------------------------------------------------------- |
| clear_sources          | `true', 'false`   | `true, false`        |                                                                         |
| include_default_source | `true', 'false`   | `true`               | Set to false to not include Chef::Config[:rubygems_url] in the sources. |
| ignore_failure         | `true', 'false`   | `false`              | Continue running a recipe if a resource fails for any reason.           |
| options                | `String`, `Hash`  |                      | Options to pass to the gem command.                                     |
| package_name           | `String`, `Array` |                      | The Gem package name to install.                                        |
| source                 | `String`, `Array` |                      | Source URL/location for gem.                                            |
| timeout                | `Integer`         | `300`                | Timeout in seconds to wait for Gem installation.                        |
| version                | `String`          |                      | Gem version to install.                                                 |
| response_file          | `String`          |                      | Response file to reconfigure a gem.                                     |
| rbenv_version          | `String`          |                      | Which rbenv version to install the Gem to.                              |
| user                   | `String`          |                      | Which user to install gem to.                                           |
| root_path              | `String`          | See root_path helper | Path to install Ruby to.                                                |

## Example

```ruby
rbenv_gem 'gem_name' do
  user 'vagrant'
end
```
