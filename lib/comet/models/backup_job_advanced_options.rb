# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # BackupJobAdvancedOptions is a typed class wrapper around the underlying Comet Server API data structure.
  # BackupJobAdvancedOptions control additional advanced options for running a backup job. They can be
# specified as part of a schedule in the BackupRuleConfig type, or supplied immediately when running
# a job.
  class BackupJobAdvancedOptions

    # @type [Boolean] skip_already_running
    attr_accessor :skip_already_running

    # If Zero: disabled
    # @type [Number] stop_after
    attr_accessor :stop_after

    # If Zero: disabled
    # @type [Number] limit_vault_speed_bps
    attr_accessor :limit_vault_speed_bps

    # Default disabled
    # @type [Boolean] reduce_disk_concurrency
    attr_accessor :reduce_disk_concurrency

    # Default disabled
    # @type [Boolean] use_on_disk_indexes
    attr_accessor :use_on_disk_indexes

    # Default disabled
    # @type [Boolean] allow_zero_files_success
    attr_accessor :allow_zero_files_success

    # If Zero: default Automatic (BACKUPJOBAUTORETENTION_AUTOMATIC)
    # @type [Number] auto_retention_level
    attr_accessor :auto_retention_level

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @stop_after = 0
      @limit_vault_speed_bps = 0
      @auto_retention_level = 0
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
        when 'SkipAlreadyRunning'
          @skip_already_running = v
        when 'StopAfter'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @stop_after = v
        when 'LimitVaultSpeedBps'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @limit_vault_speed_bps = v
        when 'ReduceDiskConcurrency'
          @reduce_disk_concurrency = v
        when 'UseOnDiskIndexes'
          @use_on_disk_indexes = v
        when 'AllowZeroFilesSuccess'
          @allow_zero_files_success = v
        when 'AutoRetentionLevel'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @auto_retention_level = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['SkipAlreadyRunning'] = @skip_already_running
      ret['StopAfter'] = @stop_after
      ret['LimitVaultSpeedBps'] = @limit_vault_speed_bps
      ret['ReduceDiskConcurrency'] = @reduce_disk_concurrency
      ret['UseOnDiskIndexes'] = @use_on_disk_indexes
      ret['AllowZeroFilesSuccess'] = @allow_zero_files_success
      ret['AutoRetentionLevel'] = @auto_retention_level
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
