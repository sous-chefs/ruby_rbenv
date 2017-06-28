# frozen_string_literal: true
global_ruby = '2.3.4'
require 'openssl'
require 'open-uri'
require 'nokogiri'

control 'Global Ruby' do
  title 'Should install Ruby globally'

  desc "can set global Ruby version to #{global_ruby}"
  describe bash('source /etc/profile.d/rbenv.sh && rbenv versions --bare') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(/#{Regexp.quote(global_ruby)}/) }
  end

  desc 'can use openssl from stdlib'
  describe bash("source /etc/profile.d/rbenv.sh && ruby -ropenssl -e 'puts OpenSSL::OPENSSL_VERSION'") do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(/OpenSSL 1.0.1e 11 Feb 2013/) }
  end

  desc 'can install nokogiri gem'
  describe bash('source /etc/profile.d/rbenv.sh && gem install nokogiri --no-ri --no-rdoc') do
    its('exit_status') { should eq 0 }
  end

  desc 'can use Nokogiri with OpenSSL'
  describe bash('source /etc/profile.d/rbenv.sh && ruby -ropen-uri -rnokogiri -e "puts Nokogiri::HTML(open(\'https://google.com\')).css(\'input\')"') do
    its('exit_status') { should eq 0 }
  end
end
