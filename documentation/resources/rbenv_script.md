# Script

Runs a rbenv aware script.

## Properties

| Name          | Type                | Default              | Description |
| ------------- | ------------------- | -------------------- | ----------- |
| user          | `String`            |                      |             |
| root_path     | `String`            | See root_path helper |             |
| rbenv_version | `String`            |                      |             |
| code          | `String`            |                      |             |
| creates       | `String`            |                      |             |
| cwd           | `String`            |                      |             |
| environment   | `Hash`              |                      |             |
| group         | `String`            |                      |             |
| path          | `Array`             |                      |             |
| returns       | `Array`             | `[0]`                |             |
| timeout       | `Integer`           |                      |             |
| umask         | `String`, `Integer` |                      |             |
| live_stream   | `true`, `false`     | `false`              |

## Examples

```ruby
rbenv_script 'foo' do
  rbenv_version '2.5.1'
  user 'vagrant'
  returns ['1','255']
  code "echo 'FOO'"
end
```

Note that environment overwrites the entire variable.
For example, setting the `$PATH` variable can be done like this:

```ruby
rbenv_script 'bundle package' do
  cwd node["bundle_dir"]
  environment ({"PATH" => "/usr/local/rbenv/shims:/usr/local/rbenv/bin:#{ENV["PATH"]}"})
  code "bundle package"
end
```

Where `#{ENV["PATH"]}` appends the existing PATH to the end of the newly set PATH.
