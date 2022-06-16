#!/usr/bin/env ruby --enable-frozen-string-literal
#
# Copyright (c) 2020-2022 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT
#
# frozen_string_literal: true

require 'json'

module Comet

  # SelfBackupTarget is a typed class wrapper around the underlying Comet Server API data structure.
  class SelfBackupTarget

    # @type [Comet::DestinationLocation] location
    attr_accessor :location

    # @type [Array<Comet::ScheduleConfig>] schedule
    attr_accessor :schedule

    # @type [String] schedule_timezone
    attr_accessor :schedule_timezone

    # @type [Comet::RetentionPolicy] retention_policy
    attr_accessor :retention_policy

    # @type [String] encryption_key
    attr_accessor :encryption_key

    # @type [Number] encryption_key_format
    attr_accessor :encryption_key_format

    # @type [Number] compression
    attr_accessor :compression

    # @type [Boolean] exclude_jobs_db
    attr_accessor :exclude_jobs_db

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @location = Comet::DestinationLocation.new
      @schedule = []
      @schedule_timezone = ''
      @retention_policy = Comet::RetentionPolicy.new
      @encryption_key = ''
      @encryption_key_format = 0
      @compression = 0
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
        when 'Location'
          @location = Comet::DestinationLocation.new
          @location.from_hash(v)
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
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Location'] = @location
      ret['Schedule'] = @schedule
      ret['ScheduleTimezone'] = @schedule_timezone
      ret['RetentionPolicy'] = @retention_policy
      ret['EncryptionKey'] = @encryption_key
      ret['EncryptionKeyFormat'] = @encryption_key_format
      ret['Compression'] = @compression
      ret['ExcludeJobsDB'] = @exclude_jobs_db
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
