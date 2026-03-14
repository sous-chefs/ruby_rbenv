# frozen_string_literal: true

# Install rbenv and makes it available to the selected user
version = '3.4.9'

# Make sure that Vagrant user is on the box for dokken
include_recipe 'test::dokken'

group 'new-group' do
  members 'vagrant'
end

# Keeps the rbenv install upto date
rbenv_user_install 'vagrant' do
  user 'vagrant'
  group 'new-group'
end

rbenv_plugin 'ruby-build' do
  git_url 'https://github.com/rbenv/ruby-build.git'
  user 'vagrant'
end

rbenv_ruby '3.4.9' do
  user 'vagrant'
end

rbenv_global version do
  user 'vagrant'
end
