#!/usr/bin/env ruby --enable-frozen-string-literal
#
# Copyright (c) 2020-2021 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT
#
# frozen_string_literal: true

require 'json'

module Comet

  # InstallToken is a typed class wrapper around the underlying Comet Server API data structure.
  class InstallToken

    # @type [String] username
    attr_accessor :username

    # @type [String] server
    attr_accessor :server

    # @type [String] token
    attr_accessor :token

    # @type [Number] create_time
    attr_accessor :create_time

    # @type [Boolean] used
    attr_accessor :used

    # @type [Number] expire_time
    attr_accessor :expire_time

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @username = ''
      @server = ''
      @token = ''
      @create_time = 0
      @expire_time = 0
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
        when 'Server'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @server = v
        when 'Token'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @token = v
        when 'CreateTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @create_time = v
        when 'Used'
          @used = v
        when 'ExpireTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @expire_time = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Username'] = @username
      ret['Server'] = @server
      ret['Token'] = @token
      ret['CreateTime'] = @create_time
      ret['Used'] = @used
      ret['ExpireTime'] = @expire_time
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
