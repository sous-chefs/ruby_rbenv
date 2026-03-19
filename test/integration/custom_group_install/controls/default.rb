# frozen_string_literal: true

global_ruby = '3.4.9'
vagrant_bash = 'runuser -u vagrant -- bash -lc'

control 'Rbenv should be installed' do
  title 'Rbenv should be installed to the users home directory'

  desc 'Rbenv should be installed'
  describe bash(%(#{vagrant_bash} "source /etc/profile.d/rbenv.sh && rbenv global")) do
    its('exit_status') { should eq 0 }
    its('stdout') { should include(global_ruby) }
  end

  describe file('/home/vagrant/.rbenv/versions') do
    it { should exist }
    it { should be_writable.by_user('vagrant') }
    its('group') { should eq 'new-group' }
  end

  describe file('/home/vagrant/.rbenv') do
    it { should exist }
    it { should be_writable.by_user('vagrant') }
    its('group') { should eq 'new-group' }
  end
end

control 'ruby-build plugin should be installed' do
  title 'ruby-build should be installed to the users home directory'
  describe bash(%(#{vagrant_bash} "source /etc/profile.d/rbenv.sh && rbenv install -L")) do
    its('exit_status') { should eq 0 }
    its('stdout') { should include('3.3') }
    its('stdout') { should include(global_ruby) }
  end
end

control 'Global Ruby' do
  title 'Rbenv should be installed globally'

  desc "Can set global Ruby version to #{global_ruby}"
  describe bash(%(#{vagrant_bash} "source /etc/profile.d/rbenv.sh && rbenv versions --bare")) do
    its('exit_status') { should eq 0 }
    its('stdout') { should include(global_ruby) }
  end
end
