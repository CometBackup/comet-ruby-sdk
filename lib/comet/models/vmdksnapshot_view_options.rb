# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # VMDKSnapshotViewOptions is a typed class wrapper around the underlying Comet Server API data structure.
  class VMDKSnapshotViewOptions

    # Request a list of stored objects in vmdk file. It should be always true for restoring single files
    # from vmdk file
    # @type [Boolean] enabled
    attr_accessor :enabled

    # The vmdk filename inside subdirectory of disk image, should be end with .vmdk
    # @type [String] partition_guid
    attr_accessor :partition_guid

    # Browse objects' paths inside vmdk file
    # @type [String] list_path
    attr_accessor :list_path

    # @type [String] partition_name
    attr_accessor :partition_name

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @partition_guid = ''
      @list_path = ''
      @partition_name = ''
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
        when 'Enabled'
          @enabled = v
        when 'PartitionGUID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @partition_guid = v
        when 'ListPath'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @list_path = v
        when 'PartitionName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @partition_name = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Enabled'] = @enabled
      ret['PartitionGUID'] = @partition_guid
      ret['ListPath'] = @list_path
      ret['PartitionName'] = @partition_name
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
