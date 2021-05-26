property :git_url,
        String,
        default: 'https://github.com/rbenv/rbenv.git',
        description: 'Git URL to download the plugin from.'

property :git_ref,
        String,
        default: 'master',
        description: 'Git reference to download, can be a SHA, tag or branch name.'
