rbenv_user_install 'vagrant' do
  update_rbenv false
end

rbenv_plugin 'ruby-build' do
  git_url 'https://github.com/rbenv/ruby-build.git'
  user 'vagrant'
end

rbenv_gem 'thor' do
  user 'vagrant'
end
