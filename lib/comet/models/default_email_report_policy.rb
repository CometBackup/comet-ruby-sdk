# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # DefaultEmailReportPolicy is a typed class wrapper around the underlying Comet Server API data structure.
  class DefaultEmailReportPolicy

    # @type [Boolean] should_override_default_reports
    attr_accessor :should_override_default_reports

    # @type [Array<Comet::EmailReportConfig>] reports
    attr_accessor :reports

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @reports = []
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
        when 'ShouldOverrideDefaultReports'
          @should_override_default_reports = v
        when 'Reports'
          if v.nil?
            @reports = []
          else
            @reports = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @reports[i1] = Comet::EmailReportConfig.new
              @reports[i1].from_hash(v1)
            end
          end
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['ShouldOverrideDefaultReports'] = @should_override_default_reports
      ret['Reports'] = @reports
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
