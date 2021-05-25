property :user,
        String,
        description: ''

property :root_path,
        String,
        default: lazy { Chef::Rbenv::Helpers.root_path(node, user) },
        description: ''
