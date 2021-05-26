# Rehash

If user is passed in, the user Ruby is rehashed rather than the system Ruby.

## Properties

| Name      | Type     | Default              | Description |
| --------- | -------- | -------------------- | ----------- |
| user      | `String` |                      |             |
| root_path | `String` | See root_path helper |             |

## Example

```ruby
rbenv_rehash 'rehash' do
  user 'vagrant'
end
```
