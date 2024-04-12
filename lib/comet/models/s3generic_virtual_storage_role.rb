# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # S3GenericVirtualStorageRole is a typed class wrapper around the underlying Comet Server API data structure.
  class S3GenericVirtualStorageRole

    # The URL for S3 API calls (e.g. "s3.amazonaws.com")
    # @type [String] s3endpoint
    attr_accessor :s3endpoint

    # The URL for IAM API calls (e.g. "iam.amazonaws.com")
    # @type [String] iamendpoint
    attr_accessor :iamendpoint

    # If set, the Storage Template will generate Storage Vaults pointing to a subdirectory within this
    # bucket. A single dynamic IAM policy will cover all created Storage Vaults.
    # This is preferable for platforms that have limits on the total number of IAM policies. However, it
    # requires a high level of IAM compatibility.
    # If left blank, the Storage Template will generate Storage Vaults pointing to new, separate S3
    # buckets each time. An additional IAM policy is created for each new Storage Vault.
    # This is preferable for platforms that have a lower level of IAM compatibility.
    # @type [String] master_bucket
    attr_accessor :master_bucket

    # @type [String] access_key
    attr_accessor :access_key

    # @type [String] secret_key
    attr_accessor :secret_key

    # @type [Boolean] use_object_lock__legacy__do_not_use
    # @deprecated This member has been deprecated since Comet version 23.x.x
    attr_accessor :use_object_lock__legacy__do_not_use

    # Control whether the resulting Storage Vaults are configured for Object Lock. One of the
    # OBJECT_LOCK_ constants
    # @type [Number] object_lock_mode
    attr_accessor :object_lock_mode

    # @type [Number] object_lock_days
    attr_accessor :object_lock_days

    # Control whether the "Allow removal of deleted files" checkbox is enabled for Storage Vaults
    # generated from this Storage Template.
    # When configuring a Storage Template from the Comet Server web interface, this field is set
    # automatically for Storage Templates using Object Lock.
    # @type [Boolean] remove_deleted
    attr_accessor :remove_deleted

    # Optional. The region to be used for new buckets. If blank, uses the default region for the
    # S3-compatible provider (e.g. us-east-1).
    # This field is available in Comet 24.3.1 and later.
    # @type [String] region
    attr_accessor :region

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @s3endpoint = ''
      @iamendpoint = ''
      @master_bucket = ''
      @access_key = ''
      @secret_key = ''
      @object_lock_mode = 0
      @object_lock_days = 0
      @region = ''
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
        when 'S3Endpoint'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @s3endpoint = v
        when 'IAMEndpoint'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @iamendpoint = v
        when 'MasterBucket'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @master_bucket = v
        when 'AccessKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @access_key = v
        when 'SecretKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @secret_key = v
        when 'UseObjectLock'
          @use_object_lock__legacy__do_not_use = v
        when 'ObjectLockMode'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @object_lock_mode = v
        when 'ObjectLockDays'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @object_lock_days = v
        when 'RemoveDeleted'
          @remove_deleted = v
        when 'Region'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @region = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['S3Endpoint'] = @s3endpoint
      ret['IAMEndpoint'] = @iamendpoint
      ret['MasterBucket'] = @master_bucket
      ret['AccessKey'] = @access_key
      ret['SecretKey'] = @secret_key
      ret['UseObjectLock'] = @use_object_lock__legacy__do_not_use
      ret['ObjectLockMode'] = @object_lock_mode
      ret['ObjectLockDays'] = @object_lock_days
      ret['RemoveDeleted'] = @remove_deleted
      ret['Region'] = @region
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
