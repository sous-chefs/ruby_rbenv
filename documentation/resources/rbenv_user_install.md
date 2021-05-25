# User_install

Installs rbenv to the user path, making rbenv available to that user only.

## Properties

| Name         | Type            | Default                              | Description |
| ------------ | --------------- | ------------------------------------ | ----------- |
| git_url      | `String`        | `https://github.com/rbenv/rbenv.git` |             |
| git_ref      | `String`        | `master`                             |             |
| user         | `String`        |                                      |             |
| group        | `String`        | user                                 |             |
| home_dir     | `String`        | `::File.expand_path("~#{user}")`     |             |
| user_prefix  | `String`        | `::File.join(home_dir, '.rbenv')`    |             |
| update_rbenv | `true`, `false` | `true`                               |             |

## Examples

```ruby
rbenv_user_install 'vagrant' do
  user 'vagrant'
end
```
