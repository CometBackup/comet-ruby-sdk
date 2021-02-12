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

  # BucketProperties is a typed class wrapper around the underlying Comet Server API data structure.
  class BucketProperties

    # @type [String] organization_id
    attr_accessor :organization_id

    # @type [Number] create_time
    attr_accessor :create_time

    # @type [Number] read_write_key_format
    attr_accessor :read_write_key_format

    # @type [String] read_write_key
    attr_accessor :read_write_key

    # @type [Comet::SizeMeasurement] size
    attr_accessor :size

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @organization_id = ''
      @create_time = 0
      @read_write_key_format = 0
      @read_write_key = ''
      @size = Comet::SizeMeasurement.new
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
        when 'OrganizationID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @organization_id = v
        when 'CreateTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @create_time = v
        when 'ReadWriteKeyFormat'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @read_write_key_format = v
        when 'ReadWriteKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @read_write_key = v
        when 'Size'
          @size = Comet::SizeMeasurement.new
          @size.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['OrganizationID'] = @organization_id
      ret['CreateTime'] = @create_time
      ret['ReadWriteKeyFormat'] = @read_write_key_format
      ret['ReadWriteKey'] = @read_write_key
      ret['Size'] = @size
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
