# Ruby SDK for the Comet Server API

[![@CometBackup on Twitter](https://img.shields.io/badge/twitter-%40CometBackup-blue.svg?style=flat)](https://twitter.com/CometBackup)
![MIT License](https://img.shields.io/packagist/l/cometbackup/comet-php-sdk.svg)

The Comet Server API allows you to create and manage customer accounts on your Comet Server.

Comet Licensing Ltd makes this library freely available under the [MIT license](https://spdx.org/licenses/MIT.html); you may embed it in any Ruby project, either free or commercial, as long as the copyright header comment remains intact in the `*.rb` files.

## Getting Started

Add this line to your application's Gemfile:

```ruby
gem 'comet_backup_ruby_sdk'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install comet_backup_ruby_sdk

If you want to build the gem from source:

    $ gem build comet_backup_ruby_sdk.gemspec

## Usage

```ruby
require 'comet_backup_ruby_sdk'

client = Comet::CometServer.new("http://127.0.0.1:8060", "admin", "admin")

profile = client.admin_get_user_profile('test-account')
puts profile.username
```

## Getting Help

Bug reports and pull requests are welcome on GitHub at [https://github.com/CometBackup/comet-ruby-sdk](https://github.com/CometBackup/comet-ruby-sdk). You may also submit issues via the ticket system at [cometbackup.com](https://cometbackup.com/).

