include Chef::Rbenv::ScriptHelpers

action :install do
  plugin_path = ::File.join(rbenv_root, 'plugins', new_resource.name)
  ref         = new_resource.git_ref || 'master'

  directory ::File.join(rbenv_root, 'plugins') do
    owner new_resource.user || 'root'
    mode  00755
  end

  git "Install #{new_resource.name} plugin" do
    destination plugin_path
    repository  new_resource.git_url
    reference   ref
    user        new_resource.user if new_resource.user
    action      :sync
  end

  new_resource.updated_by_last_action(true)
end
