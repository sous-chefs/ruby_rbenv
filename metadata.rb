name 'ruby_rbenv'
maintainer 'Sous Chefs'
maintainer_email 'help@sous-chefs.org'
license 'Apache 2.0'
description 'Manages rbenv and its installed rubies. Several LWRPs are also defined.'
long_description "Please refer to README.md (it's long)."
version '1.1.0'

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

source_url "https://github.com/sous-chefs/#{name}"
issues_url "https://github.com/sous-chefs/#{name}/issues"
chef_version '>= 12.1' if respond_to?(:chef_version)
