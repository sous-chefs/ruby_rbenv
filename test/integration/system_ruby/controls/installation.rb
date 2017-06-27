# frozen_string_literal: true
control 'Installs rbenv' do
  title 'Should install rbenv'

  desc "creates the rbenv profile"
  describe file('/etc/profile.d/rbenv.sh') do
    it { should exist }
    it { should be_file }
  end

  desc 'create the directory'
  describe file('/usr/local/rbenv') do
    it { should exist }
    it { should be_directory}
  end

  desc 'rbenv is a function'
  describe bash('source /etc/profile.d/rbenv.sh && type rbenv') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /rbenv is a function/ }
  end
end
