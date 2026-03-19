# Script

Runs a rbenv aware script.

## Properties

| Name          | Type                | Default              | Description                                                                  |
| ------------- | ------------------- | -------------------- | ---------------------------------------------------------------------------- |
| rbenv_version | `String`            |                      | Ruby version to run the script on.                                           |
| code          | `String`            |                      | Script code to run.                                                          |
| creates       | `String`            |                      | Prevent the script from creating a file when that file already exists.       |
| cwd           | `String`            |                      | The current working directory from which the command will be run.            |
| environment   | `Hash`              |                      | A Hash of environment variables in the form of ({"ENV_VARIABLE" => "VALUE"}) |
| group         | `String`            |                      | The group ID to run the command as.                                          |
| path          | `Array`             |                      | Path to add to environment.                                                  |
| returns       | `Array`             | `[0]`                | The return value for a command. This may be an array of accepted values.     |
| timeout       | `Integer`           |                      | The amount of time (in seconds) to wait for the script to complete.          |
| umask         | `String`, `Integer` |                      | The file mode creation mask, or umask.                                       |
| live_stream   | `true`, `false`     | `false`              | Live stream the output from the script to the console.                       |
| user          | `String`            |                      | Username to run the script as.                                               |
| root_path     | `String`            | See root_path helper | Path to install Ruby to.                                                     |

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
