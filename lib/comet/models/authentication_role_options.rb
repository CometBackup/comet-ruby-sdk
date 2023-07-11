# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # AuthenticationRoleOptions is a typed class wrapper around the underlying Comet Server API data structure.
  class AuthenticationRoleOptions

    # @type [Boolean] role_enabled
    attr_accessor :role_enabled

    # One of the INTEGRITYCHECK_ constants
    # @type [Number] database_check_level
    attr_accessor :database_check_level

    # @type [Boolean] generate_missed_backup_events
    attr_accessor :generate_missed_backup_events

    # Unix timestamp in seconds, before which no Missed jobs are created
    # @type [Number] no_missed_backup_events_before
    attr_accessor :no_missed_backup_events_before

    # @type [Boolean] generate_scheduled_emails
    attr_accessor :generate_scheduled_emails

    # @type [Number] prune_logs_after_days
    attr_accessor :prune_logs_after_days

    # @type [Array<Comet::RemoteStorageOption>] remote_storage
    attr_accessor :remote_storage

    # @type [Array<Comet::ReplicaServer>] replicate_to
    attr_accessor :replicate_to

    # @type [Comet::GlobalOverrideOptions] global_overrides
    attr_accessor :global_overrides

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @database_check_level = 0
      @no_missed_backup_events_before = 0
      @prune_logs_after_days = 0
      @remote_storage = []
      @replicate_to = []
      @global_overrides = Comet::GlobalOverrideOptions.new
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
        when 'RoleEnabled'
          @role_enabled = v
        when 'DatabaseCheckLevel'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @database_check_level = v
        when 'GenerateMissedBackupEvents'
          @generate_missed_backup_events = v
        when 'NoMissedBackupEventsBefore'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @no_missed_backup_events_before = v
        when 'GenerateScheduledEmails'
          @generate_scheduled_emails = v
        when 'PruneLogsAfterDays'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @prune_logs_after_days = v
        when 'RemoteStorage'
          if v.nil?
            @remote_storage = []
          else
            @remote_storage = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @remote_storage[i1] = Comet::RemoteStorageOption.new
              @remote_storage[i1].from_hash(v1)
            end
          end
        when 'ReplicateTo'
          if v.nil?
            @replicate_to = []
          else
            @replicate_to = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @replicate_to[i1] = Comet::ReplicaServer.new
              @replicate_to[i1].from_hash(v1)
            end
          end
        when 'GlobalOverrides'
          @global_overrides = Comet::GlobalOverrideOptions.new
          @global_overrides.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['RoleEnabled'] = @role_enabled
      ret['DatabaseCheckLevel'] = @database_check_level
      ret['GenerateMissedBackupEvents'] = @generate_missed_backup_events
      ret['NoMissedBackupEventsBefore'] = @no_missed_backup_events_before
      ret['GenerateScheduledEmails'] = @generate_scheduled_emails
      ret['PruneLogsAfterDays'] = @prune_logs_after_days
      ret['RemoteStorage'] = @remote_storage
      ret['ReplicateTo'] = @replicate_to
      unless @global_overrides.nil?
        ret['GlobalOverrides'] = @global_overrides
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
