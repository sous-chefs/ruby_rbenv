version = '2.4.1'

# Install Rbenv Globally
rbenv_system_install 'system'

# Install a Ruby version
rbenv_ruby version do
  live_stream true if platform?('rhel')
end

# Set that Ruby as the global Ruby
rbenv_global version
