# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'base64'
require 'json'

module Comet

  # AdminU2FRegistration is a typed class wrapper around the underlying Comet Server API data structure.
  # @deprecated This type has been deprecated since Comet version 21.12.0
  class AdminU2FRegistration

    # @type [String] description
    attr_accessor :description

    # @type [Number] register_time
    attr_accessor :register_time

    # @type [Array<Object>] registration
    attr_accessor :registration

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @description = ''
      @register_time = 0
      @registration = []
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
        when 'Description'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @description = v
        when 'RegisterTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @register_time = v
        when 'Registration'
          @registration = Base64.decode64(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Description'] = @description
      ret['RegisterTime'] = @register_time
      ret['Registration'] = Base64.strict_encode64(@registration)
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
