# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # CometDestinationLocation is a typed class wrapper around the underlying Comet Server API data structure.
  class CometDestinationLocation

    # The URL for the target Comet Server Storage Role, including http/https and trailing slash
    # @type [String] comet_server
    attr_accessor :comet_server

    # @type [String] comet_bucket
    attr_accessor :comet_bucket

    # @type [String] comet_bucket_key
    attr_accessor :comet_bucket_key

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @comet_server = ''
      @comet_bucket = ''
      @comet_bucket_key = ''
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
        when 'CometServer'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @comet_server = v
        when 'CometBucket'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @comet_bucket = v
        when 'CometBucketKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @comet_bucket_key = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['CometServer'] = @comet_server
      ret['CometBucket'] = @comet_bucket
      ret['CometBucketKey'] = @comet_bucket_key
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
