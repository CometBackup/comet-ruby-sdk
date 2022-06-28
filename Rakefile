# frozen_string_literal: true

# Copyright (c) 2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'rake/testtask'
require 'rubocop/rake_task'

# Rubocop task
RuboCop::RakeTask.new

# Minitest
Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc 'Run tests'
task default: :test
