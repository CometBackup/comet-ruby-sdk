# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # B2VirtualStorageRoleSettings is a typed class wrapper around the underlying Comet Server API data structure.
  class B2VirtualStorageRoleSettings

    # @type [String] master_bucket
    attr_accessor :master_bucket

    # @type [String] key_id
    attr_accessor :key_id

    # @type [String] app_key
    attr_accessor :app_key

    # @type [Boolean] hide_deleted_files
    attr_accessor :hide_deleted_files

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @master_bucket = ''
      @key_id = ''
      @app_key = ''
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
        when 'MasterBucket'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @master_bucket = v
        when 'KeyID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @key_id = v
        when 'AppKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @app_key = v
        when 'HideDeletedFiles'
          @hide_deleted_files = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['MasterBucket'] = @master_bucket
      ret['KeyID'] = @key_id
      ret['AppKey'] = @app_key
      ret['HideDeletedFiles'] = @hide_deleted_files
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
