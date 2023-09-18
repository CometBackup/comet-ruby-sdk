# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # WasabiVirtualStorageRoleSettings is a typed class wrapper around the underlying Comet Server API data structure.
  class WasabiVirtualStorageRoleSettings

    # @type [String] master_bucket
    attr_accessor :master_bucket

    # @type [String] access_key
    attr_accessor :access_key

    # @type [String] secret_key
    attr_accessor :secret_key

    # @type [Boolean] use_object_lock__legacy__do_not_use
    attr_accessor :use_object_lock__legacy__do_not_use

    # @type [Number] object_lock_mode
    attr_accessor :object_lock_mode

    # @type [Number] object_lock_days
    attr_accessor :object_lock_days

    # @type [Boolean] remove_deleted
    attr_accessor :remove_deleted

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @master_bucket = ''
      @access_key = ''
      @secret_key = ''
      @object_lock_mode = 0
      @object_lock_days = 0
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
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['MasterBucket'] = @master_bucket
      ret['AccessKey'] = @access_key
      ret['SecretKey'] = @secret_key
      ret['UseObjectLock'] = @use_object_lock__legacy__do_not_use
      ret['ObjectLockMode'] = @object_lock_mode
      ret['ObjectLockDays'] = @object_lock_days
      ret['RemoveDeleted'] = @remove_deleted
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
