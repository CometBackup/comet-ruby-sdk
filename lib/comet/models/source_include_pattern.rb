# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # SourceIncludePattern is a typed class wrapper around the underlying Comet Server API data structure.
  # SourceIncludePattern is used for pattern inclusions for File and Folder Protected Items
# (ENGINE_BUILTIN_FILE).
# It should be marshalled as JSON and then stored in the PINCLUDE / RINCLUDE EngineProp keys.
  class SourceIncludePattern

    # The filesystem path to search within, for matches
    # @type [String] top_directory
    attr_accessor :top_directory

    # The pattern (glob or regex format) to match
    # @type [String] value
    attr_accessor :value

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @top_directory = ''
      @value = ''
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
        when 'TopDirectory'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @top_directory = v
        when 'Value'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @value = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['TopDirectory'] = @top_directory
      ret['Value'] = @value
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
