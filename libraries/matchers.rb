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
  
  def upgrade_rbenv_gem(name)
    ChefSpec::Matchers::ResourceMatcher.new(:rbenv_gem, :upgrade, name)
  end
  
  def remove_rbenv_gem(name)
    ChefSpec::Matchers::ResourceMatcher.new(:rbenv_gem, :remove, name)
  end

  def purge_rbenv_gem(name)
    ChefSpec::Matchers::ResourceMatcher.new(:rbenv_gem, :purge, name)
  end
end
