# frozen_string_literal: true
global_ruby = '3.3.10'

control 'Global Gem Install' do
  title 'Should install Mail Gem globally'

  desc "Can set global Ruby version to #{global_ruby}"
  describe bash('source /etc/profile.d/rbenv.sh && rbenv versions --bare') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include(global_ruby) }
  end

  desc '3.4.9 Gem should have mail installed'
  describe bash('/usr/local/rbenv/versions/3.4.9/bin/gem list --local mail') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include('2.8.1') }
  end

  desc '3.3.10 Gem should not have mail installed (was removed)'
  describe bash('/usr/local/rbenv/versions/3.3.10/bin/gem list --local mail') do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not include('2.8.1') }
  end

  desc 'gem home should be rbenv in an rbenv directory'
  describe bash('source /etc/profile.d/rbenv.sh && gem env home') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include('/usr/local/rbenv/versions/') }
  end
end

control 'User Gem Install' do
  title 'Should install Bundler Gem to a user home'

  desc 'Bundler gem should be owned by vagrant'
  describe bash('ls -la /home/vagrant/.rbenv/versions/3.4.9/bin/bundler') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include('vagrant') }
  end
end
