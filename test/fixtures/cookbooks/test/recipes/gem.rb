version = '2.4.1'

rbenv_system_install 'system'

rbenv_ruby version

rbenv_global version

rbenv_gem 'mail' do
  rbenv_version
  version '2.6.5'
  options '--no-rdoc --no-ri'
end

gem_package 'mail' do
  version '2.6.5'
  options '--no-rdoc --no-ri'
end
