# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # S3DestinationLocation is a typed class wrapper around the underlying Comet Server API data structure.
  class S3DestinationLocation

    # @type [String] s3server
    attr_accessor :s3server

    # @type [Boolean] s3uses_tls
    attr_accessor :s3uses_tls

    # @type [String] s3access_key
    attr_accessor :s3access_key

    # @type [String] s3secret_key
    attr_accessor :s3secret_key

    # @type [String] s3bucket_name
    attr_accessor :s3bucket_name

    # @type [String] s3subdir
    attr_accessor :s3subdir

    # @type [String] s3custom_region
    attr_accessor :s3custom_region

    # If true, use legacy v2 signing. If false (default), use modern v4 signing
    # @type [Boolean] s3uses_v2signing
    attr_accessor :s3uses_v2signing

    # @type [Boolean] s3remove_deleted
    attr_accessor :s3remove_deleted

    # @type [Number] s3object_lock_mode
    attr_accessor :s3object_lock_mode

    # @type [Number] s3object_lock_days
    attr_accessor :s3object_lock_days

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @s3server = ''
      @s3access_key = ''
      @s3secret_key = ''
      @s3bucket_name = ''
      @s3subdir = ''
      @s3custom_region = ''
      @s3object_lock_mode = 0
      @s3object_lock_days = 0
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
        when 'S3Server'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @s3server = v
        when 'S3UsesTLS'
          @s3uses_tls = v
        when 'S3AccessKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @s3access_key = v
        when 'S3SecretKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @s3secret_key = v
        when 'S3BucketName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @s3bucket_name = v
        when 'S3Subdir'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @s3subdir = v
        when 'S3CustomRegion'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @s3custom_region = v
        when 'S3UsesV2Signing'
          @s3uses_v2signing = v
        when 'S3RemoveDeleted'
          @s3remove_deleted = v
        when 'S3ObjectLockMode'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @s3object_lock_mode = v
        when 'S3ObjectLockDays'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @s3object_lock_days = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['S3Server'] = @s3server
      ret['S3UsesTLS'] = @s3uses_tls
      ret['S3AccessKey'] = @s3access_key
      ret['S3SecretKey'] = @s3secret_key
      ret['S3BucketName'] = @s3bucket_name
      ret['S3Subdir'] = @s3subdir
      ret['S3CustomRegion'] = @s3custom_region
      ret['S3UsesV2Signing'] = @s3uses_v2signing
      ret['S3RemoveDeleted'] = @s3remove_deleted
      ret['S3ObjectLockMode'] = @s3object_lock_mode
      ret['S3ObjectLockDays'] = @s3object_lock_days
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
