# OK so this isn't "full full" right now,
# but it's a start at exercising the resource.

# Install Rbenv Globally
rbenv_system_install 'system' do
  update_rbenv false
end

rbenv_ruby '2.3.2' do
  rbenv_action 'install'
end

# Now uninstall it.
# We could just rehash it or something similar here!
rbenv_ruby '2.3.2' do
  rbenv_action 'uninstall'
end

# Install a Ruby version
rbenv_ruby '2.3.4' do
  rbenv_action 'install'
  git_url 'https://github.com/rbenv/ruby-build.git'
  build_ref 'v20170405'
end

# Set that Ruby as the global Ruby
rbenv_global '2.3.4'
