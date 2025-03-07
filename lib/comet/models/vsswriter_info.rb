# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # VSSWriterInfo is a typed class wrapper around the underlying Comet Server API data structure.
  class VSSWriterInfo

    # @type [String] display_name
    attr_accessor :display_name

    # @type [Array<Comet::VSSComponent>] components
    attr_accessor :components

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @display_name = ''
      @components = []
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
        when 'DisplayName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @display_name = v
        when 'Components'
          if v.nil?
            @components = []
          else
            @components = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @components[i1] = Comet::VSSComponent.new
              @components[i1].from_hash(v1)
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
      ret['DisplayName'] = @display_name
      ret['Components'] = @components
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
