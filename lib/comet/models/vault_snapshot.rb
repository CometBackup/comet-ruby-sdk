# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # VaultSnapshot is a typed class wrapper around the underlying Comet Server API data structure.
  class VaultSnapshot

    # @type [String] snapshot
    attr_accessor :snapshot

    # This field is available in Comet 24.3.x and later.
    # @type [String] engine_type
    attr_accessor :engine_type

    # @type [String] source
    attr_accessor :source

    # @type [Number] create_time
    attr_accessor :create_time

    # This field is available in Comet 20.12.4 and later.
    # @type [Boolean] has_original_path_info
    attr_accessor :has_original_path_info

    # This field is available in Comet 25.9.4 and later.
    # @type [Array<String>] tags
    attr_accessor :tags

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @snapshot = ''
      @engine_type = ''
      @source = ''
      @create_time = 0
      @tags = []
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
        when 'Snapshot'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @snapshot = v
        when 'EngineType'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @engine_type = v
        when 'Source'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @source = v
        when 'CreateTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @create_time = v
        when 'HasOriginalPathInfo'
          @has_original_path_info = v
        when 'Tags'
          if v.nil?
            @tags = []
          else
            @tags = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @tags[i1] = v1
            end
          end
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Snapshot'] = @snapshot
      ret['EngineType'] = @engine_type
      ret['Source'] = @source
      ret['CreateTime'] = @create_time
      ret['HasOriginalPathInfo'] = @has_original_path_info
      unless @tags.nil?
        ret['Tags'] = @tags
      end
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
