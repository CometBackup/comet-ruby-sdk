#!/usr/bin/env ruby --enable-frozen-string-literal
#
# Copyright (c) 2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT
#
# frozen_string_literal: true

require 'minitest/autorun'
require 'comet_backup_ruby_sdk'
require 'securerandom'

# TestCometServer implements some simple unit tests for the SDK
#
# To run the tests, you must pass Comet Server credentials via environment variables.
#
class TestCometServer < MiniTest::Test

  attr_accessor :server

  # setup
  #
  # Configure environment for Minitest

  def setup
    raise StandardError, 'Missing COMETSERVER_ADDRESS environment variable' unless ENV.key?('COMETSERVER_ADDRESS')
    raise StandardError, 'Missing COMETSERVER_ADMINUSER environment variable' unless ENV.key?('COMETSERVER_ADMINUSER')
    raise StandardError, 'Missing COMETSERVER_ADMINPASS environment variable' unless ENV.key?('COMETSERVER_ADMINPASS')

    @server = Comet::CometServer.new(ENV['COMETSERVER_ADDRESS'], ENV['COMETSERVER_ADMINUSER'], ENV['COMETSERVER_ADMINPASS'])
  end

  # test_server_version
  #
  # A lightweight test that the Comet Server is reachable.
  #
  # The Ruby SDK for Comet Server was first developed in the 20.6.x timeframe.
  # Assert that the target version number is realistically newer than this

  def test_server_version
    ver = @server.admin_meta_version
    assert Gem::Version.new(ver.version) >= Gem::Version.new('20.6.5')
  end

  # test_unknown_user_gives_400_status
  #
  # Test the expected 'User not found' behaviour

  def test_unknown_user_gives_400_status
    non_existent_username = "non_existent_user_#{SecureRandom.uuid}"
    begin
      @server.admin_get_user_profile(non_existent_username)
      assert false # should be unreachable
    rescue Comet::APIResponseError => e
      # On server versions prior to Organization support, returns 400 - User not found
      # On server versions with Organization support (>= 20.9.0), returns 403 - Unauthorised
      assert_includes(400..499, e.detail.status)
      assert_includes(['User not found', 'Unauthorised'], e.detail.message)
    end
  end

  # test_all_user_profiles_parseable
  #
  # Load every user account profile from the Comet Server, and perform JSON->object parsing
  # on them all.

  def test_all_user_profiles_parseable
    @server.admin_list_users_full
  end

  def test_type_assertion
    @server.admin_get_user_profile(100)
    assert false # should be unreachable
  rescue TypeError
    assert true  # correct type of exception

  # rubocop:disable Style/RescueStandardError
  rescue
    assert false # got some other kind of exception
  end
  # rubocop:enable Style/RescueStandardError

  # test_multipart
  #
  # Test use of the AdminMetaResourceNew API that uses multipart/form-data submission.

  def test_multipart
    resource_content = "comet-test-resource-content-#{SecureRandom.uuid}"
    props = @server.admin_meta_resource_new(resource_content)
    result = @server.admin_meta_resource_get(props.resource_hash)
    assert resource_content == result
  end

end
