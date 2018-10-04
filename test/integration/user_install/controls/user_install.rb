# frozen_string_literal: true

global_ruby = '2.4.1'

control 'Rbenv should be installed' do
  title 'Rbenv should be installed to the users home directory'

  desc 'Rbenv should be installed'
  describe bash('sudo -H -u vagrant bash -c "source /etc/profile.d/rbenv.sh && rbenv global"') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include(global_ruby) }
    its('stdout') { should_not include(system) }
  end

  describe file('/home/vagrant/.rbenv/versions') do
    it { should exist }
    it { should be_writable.by_user('vagrant') }
  end
end

control 'ruby-build plugin should be installed' do
  title 'ruby-build should be installed to the users home directory'
  describe bash('sudo -H -u vagrant bash -c "source /etc/profile.d/rbenv.sh && rbenv install -l"') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include('2.3.4') }
    its('stdout') { should include(global_ruby) }
  end
end

control 'Global Ruby' do
  title 'Rbenv should be installed globally'

  desc "Can set global Ruby version to #{global_ruby}"
  describe bash('sudo -H -u vagrant bash -c "source /etc/profile.d/rbenv.sh && rbenv versions --bare"') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include(global_ruby) }
  end
end
