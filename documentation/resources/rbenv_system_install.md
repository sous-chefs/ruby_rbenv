# System_install

Installs rbenv to the system location, by default `/usr/local/rbenv`

## Properties

| Name          | Type            | Default                              | Description |
| ------------- | --------------- | ------------------------------------ | ----------- |
| git_url       | String          | 'https://github.com/rbenv/rbenv.git' |             |
| git_ref       | String          | 'master'                             |             |
| global_prefix | String          | '/usr/local/rbenv'                   |             |
| update_rbenv  | `true`, `false` | `true`                               |             |

## Example

```ruby
rbenv_system_install 'foo' do
  update_rbenv 'false'
  global_prefix '/home/vagrant/.rbenv'
end
```
