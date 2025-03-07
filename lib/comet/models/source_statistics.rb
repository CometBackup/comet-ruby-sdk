# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # SourceStatistics is a typed class wrapper around the underlying Comet Server API data structure.
  class SourceStatistics

    # @type [Number] last_start_time
    attr_accessor :last_start_time

    # @type [Comet::BackupJobDetail] last_backup_job
    attr_accessor :last_backup_job

    # @type [Comet::BackupJobDetail] last_successful_backup_job
    attr_accessor :last_successful_backup_job

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @last_start_time = 0
      @last_backup_job = Comet::BackupJobDetail.new
      @last_successful_backup_job = Comet::BackupJobDetail.new
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
        when 'LastStartTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @last_start_time = v
        when 'LastBackupJob'
          @last_backup_job = Comet::BackupJobDetail.new
          @last_backup_job.from_hash(v)
        when 'LastSuccessfulBackupJob'
          @last_successful_backup_job = Comet::BackupJobDetail.new
          @last_successful_backup_job.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['LastStartTime'] = @last_start_time
      ret['LastBackupJob'] = @last_backup_job
      ret['LastSuccessfulBackupJob'] = @last_successful_backup_job
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
