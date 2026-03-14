# Plugin

Installs a rbenv plugin.
If user is passed in, the plugin is installed to the users install of rbenv.

## Properties

| Name      | Type     | Default              | Description                                                  |
| --------- | -------- | -------------------- | ------------------------------------------------------------ |
| git_url   | `String` |                      | Git URL to download the plugin from.                         |
| git_ref   | `String` | `master`             | Git reference to download, can be a SHA, tag or branch name. |
| user      | `String` |                      | Username to run the script as.                               |
| root_path | `String` | See root_path helper | Path to install Ruby to.                                     |

## Example

```ruby
rbenv_plugin 'ruby-build' do
  user 'vagrant'
end
```
