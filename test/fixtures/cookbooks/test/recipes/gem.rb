# Make sure that Vagarant user is on the box for dokken
include_recipe 'test::dokken'

# System Install
rbenv_system_install 'system'
# Install several Rubies to a system wide location
rbenv_ruby '2.4.1'
rbenv_ruby '2.3.1'
# Set System global version
rbenv_global '2.4.1'

rbenv_gem 'mail' do
  version '2.6.5'
  options '--no-rdoc --no-ri'
  rbenv_version '2.3.1'
end

rbenv_gem 'mail' do
  version '2.6.5'
  options '--no-rdoc --no-ri'
  rbenv_version '2.4.1'
end

rbenv_gem 'mail' do
  version '2.6.5'
  rbenv_version '2.4.1'
  action :remove
end

# User Install
rbenv_user_install 'vagrant'

# Install a Ruby to a user directory
rbenv_ruby '2.3.1' do
  user 'vagrant'
end

# Set the vagrant global version
rbenv_global '2.3.1' do
  user 'vagrant'
end

rbenv_gem 'bundler' do
  version '1.15.4'
  user 'vagrant'
  rbenv_version '2.3.1'
end
