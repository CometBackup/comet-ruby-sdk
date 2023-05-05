# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # EmailReportConfig is a typed class wrapper around the underlying Comet Server API data structure.
  class EmailReportConfig

    # One of the EMAILREPORTTYPE_ constants
    # @type [Number] report_type
    attr_accessor :report_type

    # Used as a list of scheduled times to send
    # @type [Array<Comet::ScheduleConfig>] summary_frequency
    attr_accessor :summary_frequency

    # Used to the determine the time bounds of a report
    # @type [Comet::TimeSpan] time_span
    attr_accessor :time_span

    # @type [Comet::SearchClause] filter
    attr_accessor :filter

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @report_type = 0
      @summary_frequency = []
      @time_span = Comet::TimeSpan.new
      @filter = Comet::SearchClause.new
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
        when 'ReportType'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @report_type = v
        when 'SummaryFrequency'
          if v.nil?
            @summary_frequency = []
          else
            @summary_frequency = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @summary_frequency[i1] = Comet::ScheduleConfig.new
              @summary_frequency[i1].from_hash(v1)
            end
          end
        when 'TimeSpan'
          @time_span = Comet::TimeSpan.new
          @time_span.from_hash(v)
        when 'Filter'
          @filter = Comet::SearchClause.new
          @filter.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['ReportType'] = @report_type
      ret['SummaryFrequency'] = @summary_frequency
      unless @time_span.nil?
        ret['TimeSpan'] = @time_span
      end
      ret['Filter'] = @filter
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
