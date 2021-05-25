# Global

Sets the global ruby version. The name of the resource is the version to set.

## Properties

| Name          | Type   | Default              | Description |
| ------------- | ------ | -------------------- | ----------- |
| rbenv_version | String |                      |             |
| user          | String |                      |             |
| root_path     | String | See root_path helper |             |

## Examples

```ruby
rbenv_global '2.5.1'
```

```ruby
rbenv_global '2.5.2' do
  user 'vagrant'
end
```

If a user is passed in to this resource it sets the global version for the user, under the users `root_path` (usually `~/.rbenv/version`), otherwise it sets the system global version.
