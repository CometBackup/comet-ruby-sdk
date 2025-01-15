# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # LoginProtectionOptions is a typed class wrapper around the underlying Comet Server API data structure.
  class LoginProtectionOptions

    # Enable this feature to block repeated failed login attempts to the Comet Server.
    # @type [Boolean] enabled
    attr_accessor :enabled

    # The number of failed attempts before a cooldown is applied. If the feature is enabled, should be
    # at least 1.
    # @type [Number] failure_threshold
    attr_accessor :failure_threshold

    # The duration to block requests, in seconds. If the feature is enabled, should be at least 1
    # second.
    # @type [Number] cooldown_seconds
    attr_accessor :cooldown_seconds

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @failure_threshold = 0
      @cooldown_seconds = 0
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
        when 'Enabled'
          @enabled = v
        when 'FailureThreshold'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @failure_threshold = v
        when 'CooldownSeconds'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @cooldown_seconds = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Enabled'] = @enabled
      ret['FailureThreshold'] = @failure_threshold
      ret['CooldownSeconds'] = @cooldown_seconds
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
