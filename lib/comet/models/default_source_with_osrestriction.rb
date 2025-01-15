# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # DefaultSourceWithOSRestriction is a typed class wrapper around the underlying Comet Server API data structure.
  class DefaultSourceWithOSRestriction

    # @type [Comet::SourceConfig] source_config
    attr_accessor :source_config

    # @type [Number] restrict_os
    attr_accessor :restrict_os

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @source_config = Comet::SourceConfig.new
      @restrict_os = 0
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
        when 'SourceConfig'
          @source_config = Comet::SourceConfig.new
          @source_config.from_hash(v)
        when 'RestrictOS'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @restrict_os = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['SourceConfig'] = @source_config
      ret['RestrictOS'] = @restrict_os
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
