# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # B2DestinationLocation is a typed class wrapper around the underlying Comet Server API data structure.
  # B2DestinationLocation allows configuring connection settings for storage locations using the
# Backblaze B2 native API (DESTINATIONTYPE_B2).
  class B2DestinationLocation

    # Key ID
    # @type [String] account_id
    attr_accessor :account_id

    # Application Key
    # @type [String] key
    attr_accessor :key

    # @type [String] bucket
    attr_accessor :bucket

    # @type [String] prefix
    attr_accessor :prefix

    # @type [Number] max_connections
    # @deprecated This member has been deprecated since Comet version 21.9.7
    attr_accessor :max_connections

    # Hide files instead of deleting them. This can be used for ransomware protection if (A) the B2
    # credentials have the hideFile permission but not the deleteFile permission, and (B) you use the
    # Backblaze B2 server-side lifecycle policies to clean up old hidden files.
    # @type [Boolean] hide_deleted_files
    attr_accessor :hide_deleted_files

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @account_id = ''
      @key = ''
      @bucket = ''
      @prefix = ''
      @max_connections = 0
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
        when 'AccountID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @account_id = v
        when 'Key'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @key = v
        when 'Bucket'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @bucket = v
        when 'Prefix'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @prefix = v
        when 'MaxConnections'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @max_connections = v
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
      unless @account_id.nil?
        ret['AccountID'] = @account_id
      end
      unless @key.nil?
        ret['Key'] = @key
      end
      unless @bucket.nil?
        ret['Bucket'] = @bucket
      end
      unless @prefix.nil?
        ret['Prefix'] = @prefix
      end
      unless @max_connections.nil?
        ret['MaxConnections'] = @max_connections
      end
      unless @hide_deleted_files.nil?
        ret['HideDeletedFiles'] = @hide_deleted_files
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
