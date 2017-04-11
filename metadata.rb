name 'ruby_rbenv'
maintainer 'Sous Chefs'
maintainer_email 'help@sous-chefs.org'
issues_url 'https://github.com/sous-chefs/ruby_rbenv/issues'
source_url 'https://github.com/sous-chefs/ruby_rbenv'
license 'Apache 2.0'
description 'Manages rbenv and its installed rubies. Several LWRPs are also defined.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.1.0'
chef_version '>= 12.0' if respond_to?(:chef_version)

depends 'ruby_build' # if using the rbenv LWRP, ruby-build must be installed

supports 'ubuntu'
supports 'linuxmint'
supports 'debian'
supports 'freebsd'
supports 'redhat'
supports 'centos'
supports 'fedora'
supports 'amazon'
supports 'scientific'
supports 'suse'
supports 'mac_os_x'
supports 'gentoo'
supports 'arch'
