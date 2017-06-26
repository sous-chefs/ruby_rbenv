# frozen_string_literal: true
global_ruby = '2.1.6'
https_url = 'https://google.com'
expr_1 = 'puts OpenSSL::PKey::RSA.new(32).to_pem'
expr_2 = "puts Nokogiri::HTML(open('$https_url')).css('input')"

control 'Global Ruby' do
  title 'Should install Ruby globally'

  desc "can set global Ruby version to #{global_ruby}"
  describe command('source /etc/profile.d/rbenv.sh') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /#{Regexp.quote(global_ruby)}/ }
  end

  desc 'can use openssl from stdlib'
  describe command("ruby -ropenssl -e #{expr_1}") do
    its('exit_status') { should eq 0 }
  end

  desc 'can install nokogiri gem'
  describe command('gem install nokogiri --no-ri --no-rdoc') do
    its('exit_status') { should eq 0 }
  end

  desc 'can use Nokogiri with OpenSSL'
  describe command("ruby -ropen-uri -rnokogiri -e #{expr_2}") do
    its('exit_status') { should eq 0 }
  end
end
