# frozen_string_literal: true
global_ruby = '2.1.6'

expr_1 = 'puts OpenSSL::PKey::RSA.new(32).to_pem'
expr_2 = "puts Nokogiri::HTML(open('https://google.com')).css('input')"

control 'Global Ruby' do
  title 'Should install Ruby globally'

  desc "can set global Ruby version to #{global_ruby}"
  describe bash('source /etc/profile.d/rbenv.sh && rbenv versions --bare') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /#{Regexp.quote(global_ruby)}/ }
  end

  desc 'can use openssl from stdlib'
  describe bash("source /etc/profile.d/rbenv.sh && ruby -ropenssl -e #{expr_1}") do
    its('exit_status') { should eq 0 }
  end

  desc 'can install nokogiri gem'
  describe bash('source /etc/profile.d/rbenv.sh && gem install nokogiri --no-ri --no-rdoc') do
    its('exit_status') { should eq 0 }
  end

  desc 'can use Nokogiri with OpenSSL'
  describe bash("source /etc/profile.d/rbenv.sh && ruby -ropen-uri -rnokogiri -e #{expr_2}") do
    its('exit_status') { should eq 0 }
  end
end
