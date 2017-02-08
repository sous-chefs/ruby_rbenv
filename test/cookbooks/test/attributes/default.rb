default['rbenv']['plugins'] = [
  {
    name: 'rbenv-vars',
    git_url: 'https://github.com/sstephenson/rbenv-vars.git',
  },
]

default['rbenv']['rubies'] = [
  {
    name: '2.1.9',
    environment: { 'CONFIGURE_OPTS' => '--disable-install-rdoc' },
  },
  {
    name: '2.2.6',
    environment: { 'CONFIGURE_OPTS' => '--disable-install-rdoc' },
  },
  {
    name: '2.3.3',
    environment: { 'CONFIGURE_OPTS' => '--disable-install-rdoc' },
  },
]

default['rbenv']['global'] = '2.3.3'
