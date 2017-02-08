if defined?(ChefSpec)

  {
    rbenv_gem: [:install, :upgrade, :remove, :purge],
    rbenv_global: [:create],
    rbenv_plugin: [:install],
    rbenv_rehash: [:run],
    rbenv_ruby: [:install, :reinstall],
    rbenv_script: [:run],
  }.each do |resource, actions|
    actions.each do |action|
      define_method("#{action}_#{resource}") do |name|
        ChefSpec::Matchers::ResourceMatcher.new(resource, action, name)
      end
    end
  end

end
