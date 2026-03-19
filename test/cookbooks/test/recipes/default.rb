# frozen_string_literal: true

# Primary smoke test: system install + Ruby + global + gem

# Make sure that Vagrant user is on the box for dokken
include_recipe 'test::dokken'

# System Install
rbenv_system_install 'system'

# Install Ruby
rbenv_ruby '3.4.9' do
  verbose true
end

# Set global Ruby version
rbenv_global '3.4.9'

# Install a gem
rbenv_gem 'bundler' do
  rbenv_version '3.4.9'
end
