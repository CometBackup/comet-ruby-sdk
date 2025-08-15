# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # ScheduleConfig is a typed class wrapper around the underlying Comet Server API data structure.
  class ScheduleConfig

    # @type [Number] frequency_type
    attr_accessor :frequency_type

    # @type [Number] seconds_past
    attr_accessor :seconds_past

    # @type [Number] offset
    attr_accessor :offset

    # @type [Boolean] restrict_runtime
    attr_accessor :restrict_runtime

    # @type [Comet::HourSchedConfig] from_time
    attr_accessor :from_time

    # @type [Comet::HourSchedConfig] to_time
    attr_accessor :to_time

    # @type [Boolean] restrict_days
    attr_accessor :restrict_days

    # @type [Comet::DaysOfWeekConfig] days_select
    attr_accessor :days_select

    # @type [Number] random_delay_secs
    attr_accessor :random_delay_secs

    # @type [Number] selected_month
    attr_accessor :selected_month

    # @type [Number] selected_day
    attr_accessor :selected_day

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @frequency_type = 0
      @seconds_past = 0
      @offset = 0
      @from_time = Comet::HourSchedConfig.new
      @to_time = Comet::HourSchedConfig.new
      @days_select = Comet::DaysOfWeekConfig.new
      @random_delay_secs = 0
      @selected_month = 0
      @selected_day = 0
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
        when 'FrequencyType'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @frequency_type = v
        when 'SecondsPast'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @seconds_past = v
        when 'Offset'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @offset = v
        when 'RestrictRuntime'
          @restrict_runtime = v
        when 'FromTime'
          @from_time = Comet::HourSchedConfig.new
          @from_time.from_hash(v)
        when 'ToTime'
          @to_time = Comet::HourSchedConfig.new
          @to_time.from_hash(v)
        when 'RestrictDays'
          @restrict_days = v
        when 'DaysSelect'
          @days_select = Comet::DaysOfWeekConfig.new
          @days_select.from_hash(v)
        when 'RandomDelaySecs'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @random_delay_secs = v
        when 'SelectedMonth'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @selected_month = v
        when 'SelectedDay'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @selected_day = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['FrequencyType'] = @frequency_type
      ret['SecondsPast'] = @seconds_past
      unless @offset.nil?
        ret['Offset'] = @offset
      end
      ret['RestrictRuntime'] = @restrict_runtime
      ret['FromTime'] = @from_time
      ret['ToTime'] = @to_time
      ret['RestrictDays'] = @restrict_days
      ret['DaysSelect'] = @days_select
      unless @random_delay_secs.nil?
        ret['RandomDelaySecs'] = @random_delay_secs
      end
      ret['SelectedMonth'] = @selected_month
      ret['SelectedDay'] = @selected_day
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
