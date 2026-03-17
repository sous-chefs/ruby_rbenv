# frozen_string_literal: true

global_ruby = '3.4.9'

control 'rbenv environment diagnostic' do
  title 'Verify rbenv environment is correctly configured'

  describe bash('getent passwd vagrant') do
    its('stdout') { should include '/home/vagrant' }
  end

  describe bash('sudo -H -u vagrant bash -c "echo HOME=\$HOME"') do
    its('stdout') { should include 'HOME=/home/vagrant' }
  end

  describe bash('sudo -H -u vagrant bash -c "test -d \$HOME/.rbenv && echo DIR_EXISTS || echo DIR_MISSING"') do
    its('stdout') { should include 'DIR_EXISTS' }
  end

  describe bash('sudo -H -u vagrant bash -c "source /etc/profile.d/rbenv.sh 2>&1; echo RBENV_ROOT=\$RBENV_ROOT; which rbenv 2>&1 || true"') do
    its('stdout') { should include 'RBENV_ROOT=/home/vagrant/.rbenv' }
  end
end

control 'Rbenv should be installed' do
  title 'Rbenv should be installed to the users home directory'

  desc 'Rbenv should be installed'
  describe bash('sudo -H -u vagrant bash -c "source /etc/profile.d/rbenv.sh && rbenv global"') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include(global_ruby) }
  end

  describe file('/home/vagrant/.rbenv/versions') do
    it { should exist }
    it { should be_writable.by_user('vagrant') }
  end
end

control 'ruby-build plugin should be installed' do
  title 'ruby-build should be installed to the users home directory'
  describe bash('sudo -H -u vagrant bash -c "source /etc/profile.d/rbenv.sh && rbenv install -L"') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include('3.3') }
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
