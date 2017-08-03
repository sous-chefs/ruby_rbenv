# Install rbenv and makes it avilable to the selected user
version = '2.4.1'

# Keeps the rbenv install upto date
rbenv_user_install 'vagrant'

rbenv_plugin 'ruby-build' do
  git_url 'https://github.com/rbenv/ruby-build.git'
  user 'vagrant'
end

rbenv_ruby '2.4.1' do
  user 'vagrant'
end

rbenv_global version do
  user 'vagrant'
end
