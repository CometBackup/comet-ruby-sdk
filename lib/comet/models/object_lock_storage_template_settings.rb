# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # ObjectLockStorageTemplateSettings is a typed class wrapper around the underlying Comet Server API data structure.
  class ObjectLockStorageTemplateSettings

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

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
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
