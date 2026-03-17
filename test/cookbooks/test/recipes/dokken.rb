# frozen_string_literal: true

# Refresh apt cache in dokken containers to avoid stale package 404s
apt_update

# Make sure Vagrant user is on the box. This should fix the dokken user install
user 'vagrant' do
  home '/home/vagrant'
  manage_home true
end

group 'vagrant' do
  members 'vagrant'
end

directory '/home/vagrant' do
  owner 'vagrant'
  group 'vagrant'
  not_if { platform?('windows') }
end

# Enable CRB/PowerTools repo on RHEL-family for libyaml-devel and other -devel packages.
# The repo exists on all RHEL derivatives but is disabled by default.
if platform_family?('rhel') && !platform?('fedora')
  package 'dnf-plugins-core'

  if node['platform_version'].to_i >= 9
    execute 'enable-crb' do
      command 'dnf config-manager --set-enabled crb'
      not_if 'dnf repolist enabled | grep -q crb'
    end
  elsif node['platform_version'].to_i == 8
    execute 'enable-powertools' do
      command 'dnf config-manager --set-enabled powertools || dnf config-manager --set-enabled PowerTools'
      not_if 'dnf repolist enabled | grep -qi powertools'
    end
  end
  package 'perl'
end
