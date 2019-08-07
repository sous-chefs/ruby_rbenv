class Chef
  module Rbenv
    module PackageDeps
      def install_ruby_dependencies
        case ::File.basename(new_resource.version)
        when /^jruby-/
          package jruby_package_deps
        else
          package_deps.each do |deps|
            package deps
          end
        end

        ensure_java_environment if new_resource.version =~ /^jruby-/
      end

      def ensure_java_environment
        resource_collection.find(
          'ruby_block[update-java-alternatives]'
        ).run_action(:create)
      rescue Chef::Exceptions::ResourceNotFound
        # have pity on my soul
        Chef::Log.info 'The java cookbook does not appear to in the run_list.'
      end

      def jruby_package_deps
        case node['platform_family']
        when 'rhel', 'fedora', 'amazon'
          %w(make gcc-c++)
        when 'debian'
          %w(make g++)
        when 'freebsd'
          %w(alsa-lib bash dejavu expat fixesproto fontconfig freetype2 gettext-runtime giflib indexinfo inputproto java-zoneinfo javavmwrapper kbproto libICE libSM libX11 libXau libXdmcp libXext libXfixes libXi libXrender libXt libXtst libfontenc libpthread-stubs libxcb libxml2 mkfontdir mkfontscale openjdk8 recordproto renderproto xextproto xproto)
        end
      end

      def package_deps
        case node['platform_family']
        when 'mac_os_x'
          %w(openssl makedepend pkg-config libyaml libffi)
        when 'rhel', 'fedora', 'amazon'
          %w(gcc bzip2 openssl-devel libyaml-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel make)
        when 'debian'
          if node['platform'] == 'ubuntu' and node['platform_version'] == '18.04'
            %w(gcc autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev make)
          else
            %w(gcc autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev make)
          end
        when 'suse'
          %w(gcc make automake gdbm-devel libyaml-devel ncurses-devel readline-devel zlib-devel libopenssl-devel )
        end
      end
    end
  end
end
