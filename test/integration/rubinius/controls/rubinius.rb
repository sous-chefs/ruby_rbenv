# frozen_string_literal: true
global_ruby = 'rbx-3.84'

control 'Rbenv should be installed' do
  title 'Rbenv should be installed globally'

  desc "Can set global Ruby version to #{global_ruby}"
  describe bash('source /etc/profile.d/rbenv.sh && rbenv versions --bare') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include(global_ruby) }
  end
end
