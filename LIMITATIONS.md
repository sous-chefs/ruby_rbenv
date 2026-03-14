# Limitations

## Installation Method

rbenv is installed from source via `git clone` — there are no binary packages.
Ruby versions are compiled from source using the [ruby-build](https://github.com/rbenv/ruby-build) plugin.

## Package Availability

This cookbook does **not** install packages for rbenv itself. It clones the rbenv
git repository and compiles Ruby from source. Build dependencies are installed
per platform family.

## Build Dependencies

| Platform Family        | Packages                                                                                                                        |
|------------------------|---------------------------------------------------------------------------------------------------------------------------------|
| Debian                 | gcc, autoconf, bison, build-essential, libssl-dev, libreadline6-dev, zlib1g-dev, libncurses5-dev, libffi-dev, libgdbm-dev, make |
| RHEL / Fedora / Amazon | gcc, bzip2, openssl-devel, libffi-devel, readline-devel, zlib-devel, gdbm-devel, ncurses-devel, make                            |
| SUSE                   | gcc, make, automake, gdbm-devel, ncurses-devel, readline-devel, zlib-devel, libopenssl-devel, bzip2                             |
| macOS                  | openssl, makedepend, pkg-config, libffi                                                                                         |

## Architecture Limitations

- Ruby compiles natively on both amd64 and arm64
- No architecture-specific restrictions from rbenv itself
- Individual Ruby versions may have architecture-specific build issues

## Platform Notes

- **macOS**: Listed in `metadata.rb` but not tested in CI. System-wide installation
  requires manual `/etc/profile.d` setup as macOS does not support this idiom natively.
- **FreeBSD**: Partial support in helper code but not listed in `metadata.rb` or tested.

## Known Issues

- Some Chef versions (>= 16 and < 16.4.41) have a bug in the `git` resource causing
  failures. Use Chef >= 16.4.41 or later.
- JRuby installations require Java to be pre-installed (not managed by this cookbook).
