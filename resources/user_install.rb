# This is used to Install & Initialize RBenv for a specific user

property :git_url, String, default: 'https://github.com/rbenv/rbenv.git'
property :git_ref, String, default: 'master'
property :user, String, name_property: true
property :home_dir, String, default: lazy { ::File.expand_path("~#{user}") }
property :user_prefix, String, default: lazy { ::File.join(home_dir, '.rbenv')}
property :global_prefix, String, default: '/usr/local/rbenv'
property :update_rbenv, [true, false], default: true

provides :rbenv_user_install

action :install do
  package package_prerequisites

# Make sure this is installed.
# It's also managed by system_install.rb
# So global_prefix should match in both files (TODO: helper)
  template '/etc/profile.d/rbenv.sh' do
    cookbook 'ruby_rbenv'
    source 'rbenv.sh.erb'
    variables({
      global_prefix: new_resource.global_prefix,
    })
    owner 'root'
    mode '0755'
  end

  git new_resource.user_prefix do
    repository new_resource.git_url
    reference new_resource.git_ref
    action :checkout if new_resource.update_rbenv == false
    user new_resource.user
    notifies :run, 'ruby_block[Add rbenv to PATH]', :immediately
  end

  directory "#{new_resource.user_prefix}/plugins" do
    owner new_resource.owner
    mode '0755'
  end

  # Initialize rbenv
  ruby_block 'Add rbenv to PATH' do
    block do
      ENV['PATH'] = "#{new_resource.user_prefix}/shims:#{new_resource.user_prefix}/bin:#{ENV['PATH']}"
    end
    action :nothing
  end

  bash 'Initialize user #{new_resource.user} rbenv' do
    code %(PATH="#{new_resource.user_prefix}/bin:$PATH" rbenv init -)
    environment('RBENV_ROOT' => new_resource.user_prefix)
    action :nothing
    subscribes :run, "git[#{new_resource.user_prefix}]", :immediately
    # Subscribe because it's easier to find the resource ;)
  end
end

action_class do
  def package_prerequisites
    case node['platform_family']
    when 'rhel', 'fedora', 'amazon'
      %w(git grep)
    when 'debian', 'suse'
      %w(git-core grep)
    when 'mac_os_x'
      %w(git)
    when 'freebsd'
      %w(git bash)
    when 'gentoo'
      %w(git)
    when 'arch'
      %w(git grep)
    end
  end
end
