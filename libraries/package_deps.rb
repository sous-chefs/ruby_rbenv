class Chef
  module Rbenv
    module PackageDeps
      def install_ruby_dependencies
        case ::File.basename(new_resource.version)
        when /^jruby-/
          package jruby_package_deps
        else
          enable_crb_repository_if_needed
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

      def enable_crb_repository_if_needed
        return unless node['platform_family'] == 'rhel' && node['platform_version'].to_i >= 9

        case node['platform']
        when 'centos'
          repository_name = 'crb'
        when 'almalinux', 'rocky'
          repository_name = 'crb'
        when 'redhat'
          repository_name = 'codeready-builder-for-rhel-9-x86_64-rpms'
        else
          repository_name = 'crb' # Default for other RHEL 9+ derivatives
        end

        # Install dnf-plugins-core if not already present
        package 'dnf-plugins-core'

        execute "enable #{repository_name} repository" do
          command "dnf config-manager --set-enabled #{repository_name}"
          not_if "dnf repolist enabled | grep -q #{repository_name}"
        end
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
          %w(openssl makedepend pkg-config libffi)
        when 'rhel', 'fedora', 'amazon'
          %w(gcc bzip2 openssl-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel make)
        when 'debian'
          if platform?('ubuntu') && node['platform_version'].to_i >= 20
            %w(gcc autoconf bison build-essential libssl-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev make)
          elsif platform?('ubuntu') && node['platform_version'].to_i >= 18
            %w(gcc autoconf bison build-essential libssl-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev make)
          elsif platform?('debian') && node['platform_version'].to_i >= 10
            %w(gcc autoconf bison build-essential libssl-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev make)
          else
            %w(gcc autoconf bison build-essential libssl-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev make)
          end
        when 'suse'
          %w(gcc make automake gdbm-devel ncurses-devel readline-devel zlib-devel libopenssl-devel bzip2)
        end
      end
    end
  end
end
