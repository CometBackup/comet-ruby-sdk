# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # BackupRuleEventTriggers is a typed class wrapper around the underlying Comet Server API data structure.
  class BackupRuleEventTriggers

    # The "When PC Starts" option
    # @type [Boolean] on_pcboot
    attr_accessor :on_pcboot

    # The "If the last job was Missed" option. In Comet 23.12.3 and later, this condition is evaluated
    # when the PC starts and/or when the live connection is resumed.
    # @type [Boolean] on_pcboot_if_last_job_missed
    attr_accessor :on_pcboot_if_last_job_missed

    # The option to enable retrying when a backup job failed.
    # This field is available in Comet 24.6.6 and later.
    # @type [Boolean] on_last_job_fail_do_retry
    attr_accessor :on_last_job_fail_do_retry

    # The number of retries when the backup job fails.
    # This field is available in Comet 24.6.6 and later.
    # @type [Number] last_job_fail_do_retry_count
    attr_accessor :last_job_fail_do_retry_count

    # The number of minutes before retrying when the backup job fails.
    # This field is available in Comet 24.6.6 and later.
    # @type [Number] last_job_fail_do_retry_time
    attr_accessor :last_job_fail_do_retry_time

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @last_job_fail_do_retry_count = 0
      @last_job_fail_do_retry_time = 0
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
        when 'OnPCBoot'
          @on_pcboot = v
        when 'OnPCBootIfLastJobMissed'
          @on_pcboot_if_last_job_missed = v
        when 'OnLastJobFailDoRetry'
          @on_last_job_fail_do_retry = v
        when 'LastJobFailDoRetryCount'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @last_job_fail_do_retry_count = v
        when 'LastJobFailDoRetryTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @last_job_fail_do_retry_time = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      unless @on_pcboot.nil?
        ret['OnPCBoot'] = @on_pcboot
      end
      unless @on_pcboot_if_last_job_missed.nil?
        ret['OnPCBootIfLastJobMissed'] = @on_pcboot_if_last_job_missed
      end
      unless @on_last_job_fail_do_retry.nil?
        ret['OnLastJobFailDoRetry'] = @on_last_job_fail_do_retry
      end
      unless @last_job_fail_do_retry_count.nil?
        ret['LastJobFailDoRetryCount'] = @last_job_fail_do_retry_count
      end
      unless @last_job_fail_do_retry_time.nil?
        ret['LastJobFailDoRetryTime'] = @last_job_fail_do_retry_time
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
