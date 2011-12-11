# <a name="description"></a> Description

Manages [rbenv][rbenv_site] and its installed Rubies.
Several lightweight resources and providers ([LWRPs][lwrp]) are also defined.

# <a name="requirements"></a> Requirements

## <a name="requirements-chef"></a> Chef

Tested on 0.10.4 but newer and older version should work just
fine. File an [issue][issues] if this isn't the case.

## <a name="requirements-platform"></a> Platform

The following platforms have been tested with this cookbook, meaning that
the recipes and LWRPs run on these platforms without error:

* ubuntu (10.04)

Please [report][issues] any additional platforms so they can be added.

## <a name="requirements-cookbooks"></a> Cookbooks

There are **no** external cookbook dependencies. However, if you
want to manage Ruby installations or use the `rbenv\_ruby` LWRP then you will
need to include the [ruby\_build cookbook][ruby_build_cb].

# <a name="installation"></a> Installation

Depending on the situation and use case there are several ways to install
this cookbook. All the methods listed below assume a tagged version release
is the target, but omit the tags to get the head of development. A valid
Chef repository structure like the [Opscode repo][chef_repo] is also assumed.

## <a name="installation-platform"></a> From the Opscode Community Platform

To install this cookbook from the Opscode platform, use the *knife* command:

    knife cookbook site install rbenv

## <a name="installation-librarian"></a> Using Librarian

The [Librarian][librarian] gem aims to be Bundler for your Chef cookbooks.
Include a reference to the cookbook in a [Cheffile][cheffile] and run
`librarian-chef install`. To install with Librarian:

    gem install librarian
    cd chef-repo
    librarian-chef init
    cat >> Cheffile <<END_OF_CHEFFILE
    cookbook 'rbenv',
      :git => 'git://github.com/fnichol/chef-rbenv.git', :ref => 'v0.6.0'
    END_OF_CHEFFILE
    librarian-chef install

## <a name="installation-kgc"></a> Using knife-github-cookbooks

The [knife-github-cookbooks][kgc] gem is a plugin for *knife* that supports
installing cookbooks directly from a GitHub repository. To install with the
plugin:

    gem install knife-github-cookbooks
    cd chef-repo
    knife cookbook github install fnichol/chef-rbenv/v0.6.0

## <a name="installation-gitsubmodule"></a> As a Git Submodule

A common practice (which is getting dated) is to add cookbooks as Git
submodules. This is accomplishes like so:

    cd chef-repo
    git submodule add git://github.com/fnichol/chef-rbenv.git cookbooks/rbenv
    git submodule init && git submodule update

**Note:** the head of development will be linked here, not a tagged release.

## <a name="installation-tarball"></a> As a Tarball

If the cookbook needs to downloaded temporarily just to be uploaded to a Chef
Server or Opscode Hosted Chef, then a tarball installation might fit the bill:

    cd chef-repo/cookbooks
    curl -Ls https://github.com/fnichol/chef-rbenv/tarball/v0.6.0 | tar xfz - && \
      mv fnichol-chef-rbenv-* rbenv

# <a name="usage"></a> Usage

Coming soon...

# <a name="recipes"></a> Recipes

## <a name="recipes-default"></a> default

Installs the rbenv codebase and initializes Chef to use the Lightweight
Resources and Providers ([LWRPs][lwrp]).

Use this recipe explicitly if you only want access to the LWRPs provided.

# <a name="attributes"></a> Attributes

Coming soon...

# <a name="lwrps"></a> Resources and Providers

Coming soon...

# <a name="development"></a> Development

* Source hosted at [GitHub][repo]
* Report issues/Questions/Feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every separate change you make.

# <a name="license"></a> License and Author

Author:: Fletcher Nichol (<fnichol@nichol.ca>)

Copyright 2011, Fletcher Nichol

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[chef_repo]:      https://github.com/opscode/chef-repo
[cheffile]:       https://github.com/applicationsonline/librarian/blob/master/lib/librarian/chef/templates/Cheffile
[kgc]:            https://github.com/websterclay/knife-github-cookbooks#readme
[librarian]:      https://github.com/applicationsonline/librarian#readme
[lwrp]:           http://wiki.opscode.com/display/chef/Lightweight+Resources+and+Providers+%28LWRP%29
[rbenv_site]:     https://github.com/sstephenson/rbenv
[ruby_build_cb]:  http://community.opscode.com/cookbooks/ruby_build

[repo]:         https://github.com/fnichol/chef-rbenv
[issues]:       https://github.com/fnichol/chef-rbenv/issues
