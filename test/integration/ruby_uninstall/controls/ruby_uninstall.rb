# frozen_string_literal: true

global_system_ruby = '2.5.1'

control 'Ruby uninstall' do
  title 'Ruby should be uninstalled'

  desc "#{global_system_ruby} should be uninstalled"
  describe bash('source /etc/profile.d/rbenv.sh && rbenv versions --bare') do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not match(/#{Regexp.quote(global_system_ruby)}/) }
  end
end
