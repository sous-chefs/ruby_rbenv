# frozen_string_literal: true
global_ruby = '2.3.4'

control 'Rbenv should be installed' do
  title 'Rbenv should be installed to the users home directory'

  desc 'Rbenv should be installed'
  describe bash('source /etc/profile.d/rbenv.sh && rbenv versions --bare') do
    its('exit_status') { should eq 0 }
  end
end
