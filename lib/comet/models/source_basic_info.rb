# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # SourceBasicInfo is a typed class wrapper around the underlying Comet Server API data structure.
  # SourceBasicInfo is the minimal amount of information one device knows about another device's
# Protected Items, in order to safely perform retention passes on their behalf.
  class SourceBasicInfo

    # @type [String] engine
    attr_accessor :engine

    # @type [String] description
    attr_accessor :description

    # @type [Number] o365account_count
    attr_accessor :o365account_count

    # @type [Number] total_vm_count
    attr_accessor :total_vm_count

    # Bytes
    # @type [Number] size
    attr_accessor :size

    # @type [Hash{String => Comet::RetentionPolicy}] override_destination_retention
    attr_accessor :override_destination_retention

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @engine = ''
      @description = ''
      @o365account_count = 0
      @total_vm_count = 0
      @size = 0
      @override_destination_retention = {}
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
        when 'Engine'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @engine = v
        when 'Description'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @description = v
        when 'O365AccountCount'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @o365account_count = v
        when 'TotalVmCount'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @total_vm_count = v
        when 'Size'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @size = v
        when 'OverrideDestinationRetention'
          @override_destination_retention = {}
          if v.nil?
            @override_destination_retention = {}
          else
            v.each do |k1, v1|
              @override_destination_retention[k1] = Comet::RetentionPolicy.new
              @override_destination_retention[k1].from_hash(v1)
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
      ret['Engine'] = @engine
      ret['Description'] = @description
      ret['O365AccountCount'] = @o365account_count
      ret['TotalVmCount'] = @total_vm_count
      ret['Size'] = @size
      unless @override_destination_retention.nil?
        ret['OverrideDestinationRetention'] = @override_destination_retention
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
