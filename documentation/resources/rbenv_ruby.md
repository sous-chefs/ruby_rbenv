# Ruby

Installs a given Ruby version to the system or user location.

## Properties

| Name               | Type            | Default                                   | Description |
| ------------------ | --------------- | ----------------------------------------- | ----------- |
| user               | String          |                                           |             |
| version            | String          |                                           |             |
| version_file       | String          |                                           |             |
| user               | String          |                                           |             |
| environment        | Hash            |                                           |             |
| rbenv_action       | String          | `install`                                 |             |
| verbose            | `true`, `false` | `false`                                   |             |
| ruby_build_git_url | String          | 'https://github.com/rbenv/ruby-build.git' |             |
| root_path          | String          | See root_path helper                      |             |

## Examples

```ruby
rbenv_ruby '2.5.1' do
  rbenv_action # Optional: the action to perform, 'install' (default), 'uninstall' etc
end
```

```ruby
rbenv_ruby '2.5.1'
```
