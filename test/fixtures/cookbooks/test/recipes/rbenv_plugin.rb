rbenv_ruby '2.3.4'

rbenv_global '2.3.4'

rbenv_plugin 'ruby-build' do
  git_url 'https://github.com/rbenv/ruby-build.git'
  destination '~/.rbenv/plugins/ruby-build'
end
