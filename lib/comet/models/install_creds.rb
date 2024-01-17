# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # InstallCreds is a typed class wrapper around the underlying Comet Server API data structure.
  class InstallCreds

    # @type [String] username
    attr_accessor :username

    # @type [String] password
    attr_accessor :password

    # @type [String] totpcode
    attr_accessor :totpcode

    # @type [String] server
    attr_accessor :server

    # @type [Boolean] auto_login
    attr_accessor :auto_login

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @username = ''
      @password = ''
      @totpcode = ''
      @server = ''
      @unknown_json_fields = {}
    end

    # @param [String] json_string The complete object in JSON format
    def from_json(json_string)
      raise TypeError, "'json_string' expected String, got #{json_string.class}" unless json_string.is_a? String

      from_hash(JSON.parse(json_string))
    end

    # @param [Hash] obj The complete object as a Ruby hash
    def from_hash(obj)
      raise TypeError, "'obj' expected Hash, got #{obj.class}" unless obj.is_a? Hash

      obj.each do |k, v|
        case k
        when 'Username'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @username = v
        when 'Password'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @password = v
        when 'TOTPCode'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @totpcode = v
        when 'Server'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @server = v
        when 'AutoLogin'
          @auto_login = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Username'] = @username
      ret['Password'] = @password
      ret['TOTPCode'] = @totpcode
      ret['Server'] = @server
      ret['AutoLogin'] = @auto_login
      @unknown_json_fields.each do |k, v|
        ret[k] = v
      end
      ret
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_h
      to_hash
    end

    # @return [String] The complete object as a JSON string
    def to_json(options = {})
      to_hash.to_json(options)
    end
  end
end
