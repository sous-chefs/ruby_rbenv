# Install rbenv and makes it avilable to the selected user

# Make sure Vagrant user is on the box. This should fix the dokken user install
user 'vagrant'

group 'vagrant' do
  members 'vagrant'
end

# Keeps the rbenv install upto date
rbenv_user_install 'vagrant' do
  update_rbenv true
end

rbenv_plugin 'ruby-build' do
  git_url 'https://github.com/rbenv/ruby-build.git'
  user 'vagrant'
end

rbenv_gem 'thor' do
  user 'vagrant'
end
