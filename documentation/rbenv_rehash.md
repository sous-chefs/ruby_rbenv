# Rehash

If user is passed in, the user Ruby is rehashed rather than the system Ruby.

## Properties

| Name      | Type     | Default              | Description                    |
| --------- | -------- | -------------------- | ------------------------------ |
| user      | `String` |                      | Username to run the script as. |
| root_path | `String` | See root_path helper | Path to install Ruby to.       |

## Example

```ruby
rbenv_rehash 'rehash' do
  user 'vagrant'
end
```
