# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # BackupRuleConfig is a typed class wrapper around the underlying Comet Server API data structure.
  # A backup rule connects one source Protected Item and one destination Storage Vault, with multiple
# time schedules or event triggers
  class BackupRuleConfig

    # @type [String] description
    attr_accessor :description

    # Unix timestamp in seconds
    # @type [Number] create_time
    attr_accessor :create_time

    # Unix timestamp in seconds. The caller is responsible for updating this themselves.
    # @type [Number] modify_time
    attr_accessor :modify_time

    # Custom commands to run before the job
    # @type [Array<String>] pre_exec
    attr_accessor :pre_exec

    # Custom commands to run after taking a disk snapshot
    # @type [Array<String>] thaw_exec
    attr_accessor :thaw_exec

    # Custom commands to run after the job
    # @type [Array<String>] post_exec
    attr_accessor :post_exec

    # The source Protected Item ID to back up from, during this schedule
    # @type [String] source
    attr_accessor :source

    # The destination Storage Vault ID to back up to, during this schedule
    # @type [String] destination
    attr_accessor :destination

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

    # Desired concurrency count. If Zero, uses mode defaults
    # @type [Number] concurrency_count
    attr_accessor :concurrency_count

    # Log verbosity level. LOG_DEBUG has the greatest verbosity
    # @type [String] log_level
    attr_accessor :log_level

    # Scheduled start times
    # @type [Array<Comet::ScheduleConfig>] schedules
    attr_accessor :schedules

    # Other events that will cause this scheduled job to start
    # @type [Comet::BackupRuleEventTriggers] event_triggers
    attr_accessor :event_triggers

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @description = ''
      @create_time = 0
      @modify_time = 0
      @pre_exec = []
      @thaw_exec = []
      @post_exec = []
      @source = ''
      @destination = ''
      @stop_after = 0
      @limit_vault_speed_bps = 0
      @auto_retention_level = 0
      @concurrency_count = 0
      @log_level = ''
      @schedules = []
      @event_triggers = Comet::BackupRuleEventTriggers.new
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
        when 'Description'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @description = v
        when 'CreateTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @create_time = v
        when 'ModifyTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @modify_time = v
        when 'PreExec'
          if v.nil?
            @pre_exec = []
          else
            @pre_exec = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @pre_exec[i1] = v1
            end
          end
        when 'ThawExec'
          if v.nil?
            @thaw_exec = []
          else
            @thaw_exec = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @thaw_exec[i1] = v1
            end
          end
        when 'PostExec'
          if v.nil?
            @post_exec = []
          else
            @post_exec = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @post_exec[i1] = v1
            end
          end
        when 'Source'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @source = v
        when 'Destination'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @destination = v
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
        when 'ConcurrencyCount'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @concurrency_count = v
        when 'LogLevel'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @log_level = v
        when 'Schedules'
          if v.nil?
            @schedules = []
          else
            @schedules = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @schedules[i1] = Comet::ScheduleConfig.new
              @schedules[i1].from_hash(v1)
            end
          end
        when 'EventTriggers'
          @event_triggers = Comet::BackupRuleEventTriggers.new
          @event_triggers.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Description'] = @description
      ret['CreateTime'] = @create_time
      ret['ModifyTime'] = @modify_time
      ret['PreExec'] = @pre_exec
      ret['ThawExec'] = @thaw_exec
      ret['PostExec'] = @post_exec
      ret['Source'] = @source
      ret['Destination'] = @destination
      ret['SkipAlreadyRunning'] = @skip_already_running
      ret['StopAfter'] = @stop_after
      ret['LimitVaultSpeedBps'] = @limit_vault_speed_bps
      ret['ReduceDiskConcurrency'] = @reduce_disk_concurrency
      ret['UseOnDiskIndexes'] = @use_on_disk_indexes
      ret['AllowZeroFilesSuccess'] = @allow_zero_files_success
      ret['AutoRetentionLevel'] = @auto_retention_level
      ret['ConcurrencyCount'] = @concurrency_count
      ret['LogLevel'] = @log_level
      ret['Schedules'] = @schedules
      ret['EventTriggers'] = @event_triggers
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
