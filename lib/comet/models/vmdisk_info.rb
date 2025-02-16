# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # VMDiskInfo is a typed class wrapper around the underlying Comet Server API data structure.
  # This type is available in Comet 24.12.x and later.
  class VMDiskInfo

    # Relative path within this backup job snapshot to root disk files
    # @type [String] path
    attr_accessor :path

    # The virtual size of the virtual disk
    # @type [Number] size
    attr_accessor :size

    # Controller number where the disk is associated to
    # @type [Number] controller
    attr_accessor :controller

    # Device number within the controller
    # @type [Number] device_num
    attr_accessor :device_num

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @path = ''
      @size = 0
      @controller = 0
      @device_num = 0
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
        when 'Path'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @path = v
        when 'Size'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @size = v
        when 'Controller'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @controller = v
        when 'DeviceNum'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @device_num = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Path'] = @path
      ret['Size'] = @size
      ret['Controller'] = @controller
      ret['DeviceNum'] = @device_num
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
