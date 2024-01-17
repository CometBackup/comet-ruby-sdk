# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # PSAConfig is a typed class wrapper around the underlying Comet Server API data structure.
  class PSAConfig

    # For PSA_TYPE_GRADIENT. Defaults to enabled
    # @type [Boolean] alerts_disabled
    attr_accessor :alerts_disabled

    # Custom headers to send with each PSA request
    # @type [Hash{String => String}] custom_headers
    attr_accessor :custom_headers

    # Specified API key for the target PSA
    # @type [String] partner_key
    attr_accessor :partner_key

    # One of the PSA_TYPE_ constants
    # @type [Number] type
    attr_accessor :type

    # The URL or subdomain for outbound PSA requests
    # @type [String] url
    attr_accessor :url

    # @type [Comet::PSAGroupedBy] grouped_by
    attr_accessor :grouped_by

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @custom_headers = {}
      @partner_key = ''
      @type = 0
      @url = ''
      @grouped_by = Comet::PSAGroupedBy.new
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
        when 'AlertsDisabled'
          @alerts_disabled = v
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
        when 'PartnerKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @partner_key = v
        when 'Type'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @type = v
        when 'URL'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @url = v
        when 'GroupedBy'
          @grouped_by = Comet::PSAGroupedBy.new
          @grouped_by.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['AlertsDisabled'] = @alerts_disabled
      unless @custom_headers.nil?
        ret['CustomHeaders'] = @custom_headers
      end
      unless @partner_key.nil?
        ret['PartnerKey'] = @partner_key
      end
      ret['Type'] = @type
      ret['URL'] = @url
      ret['GroupedBy'] = @grouped_by
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
