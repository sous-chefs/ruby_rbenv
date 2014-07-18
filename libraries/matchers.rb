if defined?(ChefSpec)
  def install_rbenv_plugin(name)
    ChefSpec::Matchers::ResourceMatcher.new(:rbenv_plugin, :install, name)
  end

  def run_rbenv_script(name)
    ChefSpec::Matchers::ResourceMatcher.new(:rbenv_script, :run, name)
  end

  def install_rbenv_gem(name)
    ChefSpec::Matchers::ResourceMatcher.new(:rbenv_gem, :install, name)
  end

  def install_rbenv_ruby(name)
    ChefSpec::Matchers::ResourceMatcher.new(:rbenv_ruby, :install, name)
  end
end
