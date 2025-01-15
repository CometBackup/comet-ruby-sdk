# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # Office365ObjectInfo is a typed class wrapper around the underlying Comet Server API data structure.
  class Office365ObjectInfo

    # @type [String] guid
    attr_accessor :guid

    # @type [String] name
    attr_accessor :name

    # @type [String] type
    attr_accessor :type

    # May be an email address or a SharePoint site URL
    # @type [String] value
    attr_accessor :value

    # @type [Array<String>] members
    attr_accessor :members

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @guid = ''
      @name = ''
      @type = ''
      @value = ''
      @members = []
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
        when 'GUID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @guid = v
        when 'Name'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @name = v
        when 'Type'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @type = v
        when 'Value'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @value = v
        when 'Members'
          if v.nil?
            @members = []
          else
            @members = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @members[i1] = v1
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
      ret['GUID'] = @guid
      ret['Name'] = @name
      ret['Type'] = @type
      ret['Value'] = @value
      ret['Members'] = @members
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
