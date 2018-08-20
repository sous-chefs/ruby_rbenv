# frozen_string_literal: true

system_ruby = '2.5.1'
user_ruby = '2.5.0'

control 'Global Ruby uninstall' do
  title 'Global Ruby should be uninstalled'

  desc "#{system_ruby} should be uninstalled"
  describe bash('source /etc/profile.d/rbenv.sh && rbenv versions --bare') do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not match(/#{Regexp.quote(system_ruby)}/) }
  end
end

control 'Local Ruby uninstall' do
  title 'Local Ruby should be uninstalled'

  desc "#{user_ruby} should be uninstalled"
  describe bash('sudo -H -u vagrant bash -c "source /etc/profile.d/rbenv.sh && rbenv versions --bare"') do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not match(/#{Regexp.quote(user_ruby)}/) }
  end
end
