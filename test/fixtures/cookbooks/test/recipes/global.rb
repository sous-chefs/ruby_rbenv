global_version = '2.4.1'

# Make sure that Vagarant user is on the box for dokken
include_recipe 'test::dokken'

# Install Rbenv Globally
rbenv_system_install 'system'

rbenv_ruby global_version do
  verbose true
end

# Set that Ruby as the global Ruby
rbenv_global global_version
