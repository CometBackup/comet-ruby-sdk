# frozen_string_literal: true

# Copyright (c) 2020-2022 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # StorjDestinationLocation is a typed class wrapper around the underlying Comet Server API data structure.
  class StorjDestinationLocation

    # @type [String] satellite_address
    attr_accessor :satellite_address

    # @type [String] apikey
    attr_accessor :apikey

    # @type [String] passphrase
    attr_accessor :passphrase

    # @type [String] storj_bucket
    attr_accessor :storj_bucket

    # @type [String] storj_bucket_prefix
    attr_accessor :storj_bucket_prefix

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @satellite_address = ''
      @apikey = ''
      @passphrase = ''
      @storj_bucket = ''
      @storj_bucket_prefix = ''
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
        when 'SatelliteAddress'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @satellite_address = v
        when 'APIKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @apikey = v
        when 'Passphrase'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @passphrase = v
        when 'StorjBucket'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @storj_bucket = v
        when 'StorjBucketPrefix'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @storj_bucket_prefix = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['SatelliteAddress'] = @satellite_address
      ret['APIKey'] = @apikey
      ret['Passphrase'] = @passphrase
      ret['StorjBucket'] = @storj_bucket
      unless @storj_bucket_prefix.nil?
        ret['StorjBucketPrefix'] = @storj_bucket_prefix
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
