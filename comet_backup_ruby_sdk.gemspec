#!/usr/bin/env ruby --enable-frozen-string-literal
#
# Copyright (c) 2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT
#
# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'comet_backup_ruby_sdk'
  spec.version       = '2.42.0'
  spec.authors       = ['Comet Licensing Ltd.']
  spec.email         = ['hello@cometbackup.com']

  spec.summary       = 'Comet Backup - Comet Server API SDK'
  spec.description   = 'The Comet Server can be controlled via an API over HTTP / HTTPS.'
  spec.homepage      = 'https://github.com/CometBackup/comet-ruby-sdk'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.1.4'
  spec.add_development_dependency 'minitest', '~> 5.14'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 0.88'
end
