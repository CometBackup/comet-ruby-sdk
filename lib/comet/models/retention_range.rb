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

  # RetentionRange is a typed class wrapper around the underlying Comet Server API data structure.
  class RetentionRange

    # @type [Number] type
    attr_accessor :type

    # @type [Number] timestamp
    attr_accessor :timestamp

    # @type [Number] jobs
    attr_accessor :jobs

    # @type [Number] days
    attr_accessor :days

    # @type [Number] weeks
    attr_accessor :weeks

    # @type [Number] months
    attr_accessor :months

    # @type [Number] week_offset
    attr_accessor :week_offset

    # @type [Number] month_offset
    attr_accessor :month_offset

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @type = 0
      @timestamp = 0
      @jobs = 0
      @days = 0
      @weeks = 0
      @months = 0
      @week_offset = 0
      @month_offset = 0
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
        when 'Type'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @type = v
        when 'Timestamp'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @timestamp = v
        when 'Jobs'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @jobs = v
        when 'Days'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @days = v
        when 'Weeks'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @weeks = v
        when 'Months'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @months = v
        when 'WeekOffset'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @week_offset = v
        when 'MonthOffset'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @month_offset = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Type'] = @type
      ret['Timestamp'] = @timestamp
      ret['Jobs'] = @jobs
      ret['Days'] = @days
      ret['Weeks'] = @weeks
      ret['Months'] = @months
      ret['WeekOffset'] = @week_offset
      ret['MonthOffset'] = @month_offset
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
