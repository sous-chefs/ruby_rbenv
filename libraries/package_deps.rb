def jruby_package_deps
  case node['platform_family']
  when 'debian'
    %w(make g++)
  when 'freebsd'
    %w( alsa-lib bash dejavu expat fixesproto fontconfig freetype2 gettext-runtime giflib indexinfo inputproto java-zoneinfo javavmwrapper kbproto libICE libSM libX11 libXau libXdmcp libXext libXfixes libXi libXrender libXt libXtst libfontenc libpthread-stubs libxcb libxml2 mkfontdir mkfontscale openjdk8 recordproto renderproto xextproto xproto )
  end
end

def package_deps
  %w( tar bash curl ) if platform_family?('rhel', 'fedora', 'debian', 'amazon', 'suse')
end

def rbx_package_deps
  case node['platform_family']
  when 'rhel', 'fedora', 'amazon'
    %w( ncurses-devel llvm-static llvm-devel ) + cruby_package_deps
  when 'suse'
    %w( ncurses-devel ) + cruby_package_deps
  end
end
