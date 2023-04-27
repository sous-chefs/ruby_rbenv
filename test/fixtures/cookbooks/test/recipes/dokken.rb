# Make sure Vagrant user is on the box. This should fix the dokken user install
user 'vagrant'

group 'vagrant' do
  members 'vagrant'
end

directory '/home/vagrant' do
  owner 'vagrant'
  group 'vagrant'
  not_if { platform?('windows') }
end

if platform_family?('rhel') && node['platform_version'].to_i >= 8
  yum_alma_baseos 'base'
  yum_alma_extras 'extras'
  yum_alma_appstream 'appstream'
  yum_alma_powertools 'powertools'
end

# package
