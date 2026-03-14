# frozen_string_literal: true

# Make sure that Vagrant user is on the box for dokken
include_recipe 'test::dokken'

# System Install
rbenv_system_install 'system'
# Install several Rubies to a system wide location
rbenv_ruby '3.3.10' do
  verbose true
end

rbenv_ruby '3.4.9' do
  verbose true
end

# Set System global version
rbenv_global '3.3.10'

rbenv_gem 'mail' do
  version '2.8.1'
  rbenv_version '3.4.9'
end

rbenv_gem 'mail' do
  version '2.8.1'
  rbenv_version '3.3.10'
end

rbenv_gem 'mail' do
  version '2.8.1'
  rbenv_version '3.3.10'
  action :remove
end

# User Install
rbenv_user_install 'vagrant'

# Install a Ruby to a user directory
rbenv_ruby '3.4.9' do
  user 'vagrant'
end

# Set the vagrant global version
rbenv_global '3.4.9' do
  user 'vagrant'
end

rbenv_gem 'bundler' do
  version '2.6.2'
  user 'vagrant'
  rbenv_version '3.4.9'
end
