# frozen_string_literal: true

system_version = '2.5.1'
user_version = '2.5.0'

# Make sure that Vagarant user is on the box for dokken
include_recipe 'test::dokken'

# System Install
rbenv_system_install 'system'

# Install system wide Ruby
rbenv_ruby system_version

# Set System global version
rbenv_global system_version

# User Install
rbenv_user_install 'vagrant'

# Install a Ruby to a user directory
rbenv_ruby user_version do
  user 'vagrant'
end
