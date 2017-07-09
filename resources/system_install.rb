property :git_url, String, default: 'https://github.com/rbenv/rbenv.git'
property :git_ref, String, default: 'master'
property :rbenv_prefix, String, default: '/usr/local/rbenv'
property :update_rbenv, [true, false], default: true

provides :rbenv_system_install

action :install do
  package package_prerequisites

  directory '/etc/profile.d' do
    owner 'root'
    mode '0755'
  end

  template '/etc/profile.d/rbenv.sh' do
    cookbook 'ruby_rbenv'
    source 'rbenv.sh.erb'
    owner 'root'
    mode '0755'
  end

  git new_resource.rbenv_prefix do
    repository new_resource.git_url
    reference new_resource.git_ref
    action :checkout if new_resource.update_rbenv == false
    notifies :run, 'ruby_block[Add rbenv to PATH]', :immediately
    notifies :run, 'bash[Initialize system rbenv]', :immediately
  end

  directory "#{new_resource.rbenv_prefix}/plugins" do
    owner 'root'
    mode '0755'
  end

  # Initialize rbenv
  ruby_block 'Add rbenv to PATH' do
    block do
      ENV['PATH'] = "#{new_resource.rbenv_prefix}/shims:#{new_resource.rbenv_prefix}/bin:#{ENV['PATH']}"
    end
    action :nothing
  end

  bash 'Initialize system rbenv' do
    code %(PATH="#{new_resource.rbenv_prefix}/bin:$PATH" rbenv init -)
    environment('RBENV_ROOT' => new_resource.rbenv_prefix)
    action :nothing
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
