# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # StatResult is a typed class wrapper around the underlying Comet Server API data structure.
  class StatResult

    # @type [Number] buckets
    attr_accessor :buckets

    # @type [Number] users
    attr_accessor :users

    # @type [Number] devices
    attr_accessor :devices

    # @type [Number] boosters
    attr_accessor :boosters

    # @type [Number] network_devices
    attr_accessor :network_devices

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @buckets = 0
      @users = 0
      @devices = 0
      @boosters = 0
      @network_devices = 0
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
        when 'Buckets'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @buckets = v
        when 'Users'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @users = v
        when 'Devices'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @devices = v
        when 'Boosters'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @boosters = v
        when 'NetworkDevices'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @network_devices = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Buckets'] = @buckets
      ret['Users'] = @users
      ret['Devices'] = @devices
      ret['Boosters'] = @boosters
      ret['NetworkDevices'] = @network_devices
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
