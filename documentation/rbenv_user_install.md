# User_install

Installs rbenv to the user path, making rbenv available to that user only.

## Properties

| Name         | Type            | Default                              | Description                                                  |
| ------------ | --------------- | ------------------------------------ | ------------------------------------------------------------ |
| git_url      | `String`        | `https://github.com/rbenv/rbenv.git` | Git URL to rbenv from.                                       |
| git_ref      | `String`        | `master`                             | Git reference to download, can be a SHA, tag or branch name. |
| user         | `String`        |                                      | User to install the Ruby to.                                 |
| group        | `String`        | user                                 | Group to create the resources with.                          |
| home_dir     | `String`        | `::File.expand_path("~#{user}")`     | Directory to point user_prefix to.                           |
| user_prefix  | `String`        | `::File.join(home_dir, '.rbenv')`    | Location to install Ruby.                                    |
| update_rbenv | `true`, `false` | `true`                               | Update rbenv definitions.                                    |

## Examples

```ruby
rbenv_user_install 'vagrant' do
  user 'vagrant'
end
```
