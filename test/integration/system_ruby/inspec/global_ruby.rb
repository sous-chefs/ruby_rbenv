# frozen_string_literal: true
title 'Should install Ruby globally'

global_ruby="2.1.6"
https_url="https://google.com"
expr="puts OpenSSL::PKey::RSA.new(32).to_pem"

# setup() {
#   unset GEM_HOME
#   unset GEM_PATH
#   unset GEM_CACHE
#   source /etc/profile.d/rbenv.sh
# }

control 'Install Ruby globally' do
  desc 'installs $global_ruby'
  describe command('rbenv versions --bare') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /#{Regexp.quote(global_ruby)}/ }
  end
end

control 'A global Ruby version is set' do
  desc "Sets global Ruby version to #{global_ruby}"
  describe command('rbenv versions --bare') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /#{Regexp.quote(global_ruby)}/ }
  end

  desc 'global Ruby can use openssl from stdlib'
  describe command("ruby -ropenssl -e #{expr}") do
    its('exit_status') { should eq 0 }
  end
end

# @test "global Ruby can install nokogiri gem" {
#   export RBENV_VERSION=$global_ruby
#   run gem install nokogiri --no-ri --no-rdoc
#   [ $status -eq 0 ]
# }
#
# @test "global Ruby can use nokogiri with openssl" {
#   export RBENV_VERSION=$global_ruby
#   expr="puts Nokogiri::HTML(open('$https_url')).css('input')"
#   run ruby -ropen-uri -rnokogiri -e "$expr"
#   [ $status -eq 0 ]
# }
