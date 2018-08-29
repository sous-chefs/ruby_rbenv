# frozen_string_literal: true

control 'Rbenv system install' do
  title 'Rbenv should be installed system wide'

  desc 'Rbenv should be installed and run successfully'
  describe bash('source /etc/profile.d/rbenv.sh && rbenv versions --bare') do
    its('exit_status') { should eq 0 }
  end
end

control 'Rbenv system path' do
  title 'Rbenv should be installed in the system wide location'

  describe file('/usr/local/rbenv') do
    it { should exist }
    it { should be_directory }
  end
end
