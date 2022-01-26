# Ruby

Installs a given Ruby version to the system or user location.

## Properties

| Name               | Type            | Default                                   | Description                             |
| ------------------ | --------------- | ----------------------------------------- | --------------------------------------- |
| version            | `String`        |                                           | Ruby version to install.                |
| environment        | `Hash`          |                                           | Environment to pass to the Ruby script. |
| rbenv_action       | `String`        | `install`                                 | Action to pass to rbenv.                |
| verbose            | `true`, `false` | `false`                                   | Build Ruby with verbose output.         |
| ruby_build_git_url | `String`        | `https://github.com/rbenv/ruby-build.git` | Git URL for Ruby build.                 |
| user               | `String`        |                                           | Username to run the script as.          |
| root_path          | `String`        | See root_path helper                      | Path to install Ruby to.                |

## Examples

```ruby
rbenv_ruby '2.5.1' do
  user 'vagrant'
end
```

```ruby
rbenv_ruby '2.5.1'
```
