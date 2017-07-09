# frozen_string_literal: true
global_ruby = '2.3.4'

control 'Gem Install' do
  title 'Should install Mail Gem globally'

  desc "Can set global Ruby version to #{global_ruby}"
  describe bash('source /etc/profile.d/rbenv.sh && rbenv versions --bare') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(/#{Regexp.quote(global_ruby)}/) }
  end

  desc 'Thor gem should be installed'
  describe bash('source /etc/profile.d/rbenv.sh && gem list') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(/mail (2.6.5)/) }
    its('stdout') { should_not match(/mail (2.6.6)/) }
  end

  desc 'gem home should include rbenv'
  describe bash('gem env home') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(%r{~/.rbenv/versions/#{Regexp.quote(global_ruby)}/lib/ruby/gems/}) }
  end
end
