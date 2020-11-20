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

  # DestinationStatistics is a typed class wrapper around the underlying Comet Server API data structure.
  class DestinationStatistics

    # @type [Comet::SizeMeasurement] client_provided_size
    attr_accessor :client_provided_size

    # @type [Comet::ContentMeasurement] client_provided_content
    attr_accessor :client_provided_content

    # @type [String] last_successful_deep_verify__guid
    attr_accessor :last_successful_deep_verify__guid

    # @type [Number] last_successful_deep_verify__start_time
    attr_accessor :last_successful_deep_verify__start_time

    # @type [Number] last_successful_deep_verify__end_time
    attr_accessor :last_successful_deep_verify__end_time

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @client_provided_size = Comet::SizeMeasurement.new
      @client_provided_content = Comet::ContentMeasurement.new
      @last_successful_deep_verify__guid = ''
      @last_successful_deep_verify__start_time = 0
      @last_successful_deep_verify__end_time = 0
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
        when 'ClientProvidedSize'
          @client_provided_size = Comet::SizeMeasurement.new
          @client_provided_size.from_hash(v)
        when 'ClientProvidedContent'
          @client_provided_content = Comet::ContentMeasurement.new
          @client_provided_content.from_hash(v)
        when 'LastSuccessfulDeepVerify_GUID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @last_successful_deep_verify__guid = v
        when 'LastSuccessfulDeepVerify_StartTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @last_successful_deep_verify__start_time = v
        when 'LastSuccessfulDeepVerify_EndTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @last_successful_deep_verify__end_time = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['ClientProvidedSize'] = @client_provided_size
      ret['ClientProvidedContent'] = @client_provided_content
      unless @last_successful_deep_verify__guid.nil?
        ret['LastSuccessfulDeepVerify_GUID'] = @last_successful_deep_verify__guid
      end
      unless @last_successful_deep_verify__start_time.nil?
        ret['LastSuccessfulDeepVerify_StartTime'] = @last_successful_deep_verify__start_time
      end
      unless @last_successful_deep_verify__end_time.nil?
        ret['LastSuccessfulDeepVerify_EndTime'] = @last_successful_deep_verify__end_time
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
