# Ruby SDK for the Comet Server API

[![@CometBackup on Twitter](https://img.shields.io/badge/twitter-%40CometBackup-blue.svg?style=flat)](https://twitter.com/CometBackup)
![MIT License](https://img.shields.io/packagist/l/cometbackup/comet-php-sdk.svg)

The Comet Server API allows you to create and manage customer accounts on your Comet Server.

Comet Licensing Ltd makes this library freely available under the [MIT license](https://spdx.org/licenses/MIT.html); you may embed it in any Ruby project, either free or commercial, as long as the copyright header comment remains intact in the `*.rb` files.

## Features

- Full coverage of Comet Server API methods, data structures, and constant definitions

## Version compatibility

This library uses [Semantic Versioning](https://semver.org/). However, large parts of this library are autogenerated from internal protocol descriptions from a specific version of Comet Server; to find the source Comet Server version, check the `Comet::APPLICATION_VERSION` constant.

Newer API libraries can be safely used with older versions of Comet Server, however some features may be unavailable, and any new API properties will be unrecognized and ignored by the Comet Server.

Older API libraries can be safely used with newer versions of Comet Server. Unknown API properties corresponding to new Comet Server features will be preserved via the `@unknown_json_fields` system.

## Getting Started

This package is provided as a Gem hosted on [rubygems.org](https://rubygems.org/).

Install using [Bundler](https://bundler.io/):

```bash
echo "gem 'comet_backup_ruby_sdk'" >> Gemfile
bundle
```

Or install using [Gem](https://rubygems.org/):

    $ gem install comet_backup_ruby_sdk

To compile the gem from source:

```bash
git clone https://github.com/CometBackup/comet-ruby-sdk.git
cd comet-ruby-sdk
gem build comet_backup_ruby_sdk.gemspec
```

## Usage

```ruby
require 'comet_backup_ruby_sdk'

client = Comet::CometServer.new("http://127.0.0.1:8060", "admin", "admin")

client.admin_list_users_full.each do |username, profile|
  puts "#{username} has #{profile.destinations.length} Storage Vault(s)"
end
```

## Getting Help

Bug reports and pull requests are welcome on GitHub at [https://github.com/CometBackup/comet-ruby-sdk](https://github.com/CometBackup/comet-ruby-sdk).

You may also submit issues via the ticket system at [cometbackup.com](https://cometbackup.com/).
