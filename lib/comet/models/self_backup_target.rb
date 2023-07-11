# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # SelfBackupTarget is a typed class wrapper around the underlying Comet Server API data structure.
  class SelfBackupTarget

    # @type [Array<Comet::ScheduleConfig>] schedule
    attr_accessor :schedule

    # Timezone in IANA format
    # @type [String] schedule_timezone
    attr_accessor :schedule_timezone

    # @type [Comet::RetentionPolicy] retention_policy
    attr_accessor :retention_policy

    # @type [Comet::DestinationLocation] location
    attr_accessor :location

    # @type [String] encryption_key
    attr_accessor :encryption_key

    # One of the ENCRYPTIONMETHOD_ constants
    # @type [Number] encryption_key_format
    attr_accessor :encryption_key_format

    # One of the COMPRESS_LVL_ constants
    # @type [Number] compression
    attr_accessor :compression

    # The jobs database is often the largest component of the Server Self-Backup archive. By excluding
    # it, you could run the Server Self-Backup more often.
    # @type [Boolean] exclude_jobs_db
    attr_accessor :exclude_jobs_db

    # @type [Boolean] include_server_logs
    attr_accessor :include_server_logs

    # @type [String] restrict_to_single_org_id
    attr_accessor :restrict_to_single_org_id

    # @type [Number] index
    attr_accessor :index

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @schedule = []
      @schedule_timezone = ''
      @retention_policy = Comet::RetentionPolicy.new
      @location = Comet::DestinationLocation.new
      @encryption_key = ''
      @encryption_key_format = 0
      @compression = 0
      @restrict_to_single_org_id = ''
      @index = 0
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
        when 'Schedule'
          if v.nil?
            @schedule = []
          else
            @schedule = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @schedule[i1] = Comet::ScheduleConfig.new
              @schedule[i1].from_hash(v1)
            end
          end
        when 'ScheduleTimezone'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @schedule_timezone = v
        when 'RetentionPolicy'
          @retention_policy = Comet::RetentionPolicy.new
          @retention_policy.from_hash(v)
        when 'Location'
          @location = Comet::DestinationLocation.new
          @location.from_hash(v)
        when 'EncryptionKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @encryption_key = v
        when 'EncryptionKeyFormat'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @encryption_key_format = v
        when 'Compression'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @compression = v
        when 'ExcludeJobsDB'
          @exclude_jobs_db = v
        when 'IncludeServerLogs'
          @include_server_logs = v
        when 'RestrictToSingleOrgID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @restrict_to_single_org_id = v
        when 'Index'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @index = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Schedule'] = @schedule
      ret['ScheduleTimezone'] = @schedule_timezone
      ret['RetentionPolicy'] = @retention_policy
      ret['Location'] = @location
      ret['EncryptionKey'] = @encryption_key
      ret['EncryptionKeyFormat'] = @encryption_key_format
      ret['Compression'] = @compression
      ret['ExcludeJobsDB'] = @exclude_jobs_db
      ret['IncludeServerLogs'] = @include_server_logs
      unless @restrict_to_single_org_id.nil?
        ret['RestrictToSingleOrgID'] = @restrict_to_single_org_id
      end
      ret['Index'] = @index
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
