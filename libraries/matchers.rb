if defined?(ChefSpec)
  def install_rbenv_plugin(name)
    ChefSpec::Matchers::ResourceMatcher.new(:rbenv_plugin, :install, name)
  end
end
