# frozen_string_literal: true

# Make sure that Vagrant user is on the box for dokken
include_recipe 'test::dokken'

# Install Rbenv to the system path e.g. /usr/local/rbenv
rbenv_system_install 'system' do
  update_rbenv false
end
