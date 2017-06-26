
provides :rbenv_plugin

property :name, String, name_property: true
property :git_url, String
property :git_ref, String, default: 'master'
property :user, String
property :root_path, String, default: 'root'

default_action :install

action_class do
  include Chef::Rbenv::ScriptHelpers
end

action :install do
  directory ::File.join(rbenv_root, 'plugins') do
    owner new_resource.user
    mode '0755'
    action :create
  end

  plugin_path = ::File.join(rbenv_root, 'plugins', new_resource.name)

  git "Install #{new_resource.name} plugin" do
    destination plugin_path
    repository new_resource.git_url
    reference new_resource.git_ref
    user new_resource.user if new_resource.user
    action :sync
  end
end
