# frozen_string_literal: true

control 'Rbenv should be installed' do
  title 'Rbenv should be installed to the users home directory'

  desc 'Rbenv should be installed'
  describe bash('sudo -H -u vagrant bash -c "source /etc/profile.d/rbenv.sh && rbenv global"') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(/system/) }

  end
end


# vagrant source /etc/profile.d/rbenv.sh && rbenv install -l
