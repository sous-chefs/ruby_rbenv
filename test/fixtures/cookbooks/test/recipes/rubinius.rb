# Install Rbenv Globally
rbenv_system_install 'system'

rbenv_ruby '2.4.1' do
  verbose true
end
# Set that Ruby as the global Ruby
rbenv_global '2.4.1'

# Install a Ruby version
rbenv_ruby 'rbx-3.84' do
  verbose true
end
