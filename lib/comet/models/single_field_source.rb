# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # SingleFieldSource is a typed class wrapper around the underlying Comet Server API data structure.
  class SingleFieldSource

    # @type [String] field_name
    attr_accessor :field_name

    # One of "bool" / "int" / "string"
    # @type [String] field_type
    attr_accessor :field_type

    # @type [Boolean] bool_val
    attr_accessor :bool_val

    # @type [Number] int_val
    attr_accessor :int_val

    # @type [String] str_val
    attr_accessor :str_val

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @field_name = ''
      @field_type = ''
      @int_val = 0
      @str_val = ''
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
        when 'FieldName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @field_name = v
        when 'FieldType'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @field_type = v
        when 'BoolVal'
          @bool_val = v
        when 'IntVal'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @int_val = v
        when 'StrVal'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @str_val = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['FieldName'] = @field_name
      ret['FieldType'] = @field_type
      ret['BoolVal'] = @bool_val
      ret['IntVal'] = @int_val
      ret['StrVal'] = @str_val
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
