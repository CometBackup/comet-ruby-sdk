# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # EmailReportingOption is a typed class wrapper around the underlying Comet Server API data structure.
  class EmailReportingOption

    # @type [Comet::EmailReportConfig] email_report_config
    attr_accessor :email_report_config

    # A supported language code (e.g. "en_US" or the DEFAULT_LANGUAGE constant)
    # @type [String] language_code
    attr_accessor :language_code

    # The timezone in IANA format (e.g. "Pacific/Auckland" or the DEFAULT_TIMEZONE constant)
    # @type [String] local_timezone
    attr_accessor :local_timezone

    # @type [Array<String>] recipients
    attr_accessor :recipients

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @email_report_config = Comet::EmailReportConfig.new
      @language_code = ''
      @local_timezone = ''
      @recipients = []
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
        when 'EmailReportConfig'
          @email_report_config = Comet::EmailReportConfig.new
          @email_report_config.from_hash(v)
        when 'LanguageCode'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @language_code = v
        when 'LocalTimezone'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @local_timezone = v
        when 'Recipients'
          if v.nil?
            @recipients = []
          else
            @recipients = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @recipients[i1] = v1
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
      ret['EmailReportConfig'] = @email_report_config
      ret['LanguageCode'] = @language_code
      ret['LocalTimezone'] = @local_timezone
      ret['Recipients'] = @recipients
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
