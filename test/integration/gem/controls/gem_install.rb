# frozen_string_literal: true
global_ruby = '2.4.1'

control 'Global Gem Install' do
  title 'Should install Mail Gem globally'

  desc "Can set global Ruby version to #{global_ruby}"
  describe bash('source /etc/profile.d/rbenv.sh && rbenv versions --bare') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include(global_ruby) }
  end

  desc '2.3.1 Gem should have mail installed'
  describe bash('/usr/local/rbenv/versions/2.3.1/bin/gem list --local mail') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include('2.6.5') }
    its('stdout') { should_not include('2.6.6') }
  end

  desc '2.4.1 Gem should not have any mail version installed'
  describe bash('/usr/local/rbenv/versions/2.4.1/bin/gem list --local') do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not include('2.6.5') }
    its('stdout') { should_not include('2.6.6') }
  end

  desc 'gem home should be rbenv in an rbenv directory'
  describe bash('source /etc/profile.d/rbenv.sh && gem env home') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include("/usr/local/rbenv/versions/#{global_ruby}/lib/ruby/gems/2.4.0") }
  end
end

control 'User Gem Install' do
  title 'Should install Bundler Gem to a user home'

  desc 'Gemspec file should have correct ownership'
  describe file('/home/vagrant/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/specifications/bundler-1.15.4.gemspec') do
    it { should exist }
    it { should be_owned_by 'vagrant' }
  end
end
