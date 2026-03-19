# frozen_string_literal: true

ruby_version = '3.4.9'

control 'rbenv-system-install' do
  impact 1.0
  title 'rbenv should be installed system-wide'

  describe file('/usr/local/rbenv') do
    it { should exist }
    it { should be_directory }
  end

  describe file('/etc/profile.d/rbenv.sh') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end

  describe bash('source /etc/profile.d/rbenv.sh && rbenv versions --bare') do
    its('exit_status') { should eq 0 }
  end
end

control 'rbenv-ruby-installed' do
  impact 1.0
  title "Ruby #{ruby_version} should be installed"

  describe bash('source /etc/profile.d/rbenv.sh && rbenv versions --bare') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include(ruby_version) }
  end

  describe file("/usr/local/rbenv/versions/#{ruby_version}/bin/ruby") do
    it { should exist }
    it { should be_executable }
  end
end

control 'rbenv-global-version' do
  impact 1.0
  title "Global Ruby version should be #{ruby_version}"

  describe bash('source /etc/profile.d/rbenv.sh && rbenv global') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(/#{Regexp.quote(ruby_version)}/) }
  end
end

control 'rbenv-gem-installed' do
  impact 0.7
  title 'Bundler gem should be installed'

  describe bash("source /etc/profile.d/rbenv.sh && /usr/local/rbenv/versions/#{ruby_version}/bin/gem list --local bundler") do
    its('exit_status') { should eq 0 }
    its('stdout') { should include('bundler') }
  end
end
