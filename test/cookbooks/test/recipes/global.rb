# frozen_string_literal: true

global_version = '3.4.9'

# Make sure that Vagrant user is on the box for dokken
include_recipe 'test::dokken'

# Install Rbenv Globally
rbenv_system_install 'system'

rbenv_ruby global_version do
  verbose true
end

# Set that Ruby as the global Ruby
rbenv_global global_version
