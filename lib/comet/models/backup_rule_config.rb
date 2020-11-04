#!/usr/bin/env ruby --enable-frozen-string-literal
#
# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT
#
# frozen_string_literal: true

require 'json'

module Comet

  # BackupRuleConfig is a typed class wrapper around the underlying Comet Server API data structure.
  class BackupRuleConfig

    # @type [String] description
    attr_accessor :description

    # @type [Number] create_time
    attr_accessor :create_time

    # @type [Number] modify_time
    attr_accessor :modify_time

    # @type [Array<String>] pre_exec
    attr_accessor :pre_exec

    # @type [Array<String>] thaw_exec
    attr_accessor :thaw_exec

    # @type [Array<String>] post_exec
    attr_accessor :post_exec

    # @type [String] source
    attr_accessor :source

    # @type [String] destination
    attr_accessor :destination

    # @type [Boolean] skip_already_running
    attr_accessor :skip_already_running

    # @type [Number] stop_after
    attr_accessor :stop_after

    # @type [Number] limit_vault_speed_bps
    attr_accessor :limit_vault_speed_bps

    # @type [Boolean] reduce_disk_concurrency
    attr_accessor :reduce_disk_concurrency

    # @type [Boolean] use_on_disk_indexes
    attr_accessor :use_on_disk_indexes

    # @type [Boolean] allow_zero_files_success
    attr_accessor :allow_zero_files_success

    # @type [Array<Comet::ScheduleConfig>] schedules
    attr_accessor :schedules

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
      @schedules = []
      @event_triggers = Comet::BackupRuleEventTriggers.new
      @unknown_json_fields = {}
    end

    # @param [String] json_string The complete object in JSON format
    def from_json(json_string)
      raise TypeError "'json_string' expected String, got #{json_string.class}" unless json_string.is_a? String

      from_hash(JSON.parse(json_string))
    end

    # @param [Hash] obj The complete object as a Ruby hash
    def from_hash(obj)
      raise TypeError "'obj' expected Hash, got #{obj.class}" unless obj.is_a? Hash

      obj.each do |k, v|
        case k
        when 'Description'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @description = v
        when 'CreateTime'
          raise TypeError "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @create_time = v
        when 'ModifyTime'
          raise TypeError "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @modify_time = v
        when 'PreExec'
          if v.nil?
            @pre_exec = []
          else
            @pre_exec = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @pre_exec[i1] = v1
            end
          end
        when 'ThawExec'
          if v.nil?
            @thaw_exec = []
          else
            @thaw_exec = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @thaw_exec[i1] = v1
            end
          end
        when 'PostExec'
          if v.nil?
            @post_exec = []
          else
            @post_exec = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @post_exec[i1] = v1
            end
          end
        when 'Source'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @source = v
        when 'Destination'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @destination = v
        when 'SkipAlreadyRunning'
          @skip_already_running = v
        when 'StopAfter'
          raise TypeError "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @stop_after = v
        when 'LimitVaultSpeedBps'
          raise TypeError "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @limit_vault_speed_bps = v
        when 'ReduceDiskConcurrency'
          @reduce_disk_concurrency = v
        when 'UseOnDiskIndexes'
          @use_on_disk_indexes = v
        when 'AllowZeroFilesSuccess'
          @allow_zero_files_success = v
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
