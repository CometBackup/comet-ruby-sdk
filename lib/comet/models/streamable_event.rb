# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # StreamableEvent is a typed class wrapper around the underlying Comet Server API data structure.
  class StreamableEvent

    # @type [String] actor
    attr_accessor :actor

    # @type [String] owner_organization_id
    attr_accessor :owner_organization_id

    # @type [String] resource_id
    attr_accessor :resource_id

    # @type [Number] type
    attr_accessor :type

    # @type [Number] timestamp
    attr_accessor :timestamp

    # @type [String] type_string
    attr_accessor :type_string

    # @type [Object] data
    attr_accessor :data

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @actor = ''
      @owner_organization_id = ''
      @resource_id = ''
      @type = 0
      @timestamp = 0
      @type_string = ''
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
        when 'Actor'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @actor = v
        when 'OwnerOrganizationID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @owner_organization_id = v
        when 'ResourceID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @resource_id = v
        when 'Type'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @type = v
        when 'Timestamp'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @timestamp = v
        when 'TypeString'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @type_string = v
        when 'Data'
          @data = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Actor'] = @actor
      ret['OwnerOrganizationID'] = @owner_organization_id
      unless @resource_id.nil?
        ret['ResourceID'] = @resource_id
      end
      ret['Type'] = @type
      unless @timestamp.nil?
        ret['Timestamp'] = @timestamp
      end
      unless @type_string.nil?
        ret['TypeString'] = @type_string
      end
      unless @data.nil?
        ret['Data'] = @data
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
