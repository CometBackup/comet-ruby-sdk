# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # WebhookOption is a typed class wrapper around the underlying Comet Server API data structure.
  # WebhookOption defines the configuration of a webhook target. The Comet Server will send a live
# HTTP POST event to the webhook URL when certain events happen.
  class WebhookOption

    # The target URL to POST the event data to
    # @type [String] url
    attr_accessor :url

    # CustomHeaders allows specifying custom headers which are added to the outgoing POST request
    # from Comet Server. Custom headers are specified as (header name, header value) pairs. If a
    # custom header conflicts with a header required by HTTP or the Comet tracing ID header
    # (`x-Comet-Tracing-Id`), it will be ignored.
    # @type [Hash{String => String}] custom_headers
    attr_accessor :custom_headers

    # One of the STREAM_LEVEL_ constants. This controls how much data is sent in the webhook event.
    # @type [String] level
    attr_accessor :level

    # Configure a subset of allowed event types (see SEVT_ constants). If the array is empty, all events
    # will be sent
    # @type [Array<Number>] white_listed_event_types
    attr_accessor :white_listed_event_types

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @url = ''
      @custom_headers = {}
      @level = ''
      @white_listed_event_types = []
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
        when 'URL'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @url = v
        when 'CustomHeaders'
          @custom_headers = {}
          if v.nil?
            @custom_headers = {}
          else
            v.each do |k1, v1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @custom_headers[k1] = v1
            end
          end
        when 'Level'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @level = v
        when 'WhiteListedEventTypes'
          if v.nil?
            @white_listed_event_types = []
          else
            @white_listed_event_types = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected Numeric, got #{v1.class}" unless v1.is_a? Numeric

              @white_listed_event_types[i1] = v1
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
      ret['URL'] = @url
      ret['CustomHeaders'] = @custom_headers
      ret['Level'] = @level
      ret['WhiteListedEventTypes'] = @white_listed_event_types
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
