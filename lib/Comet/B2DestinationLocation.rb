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

  # B2DestinationLocation is a typed class wrapper around the underlying Comet Server API data structure.
  class B2DestinationLocation

    # @type [String] account_id
    attr_accessor :account_id

    # @type [String] key
    attr_accessor :key

    # @type [String] bucket
    attr_accessor :bucket

    # @type [String] prefix
    attr_accessor :prefix

    # @type [Number] max_connections
    attr_accessor :max_connections

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      @unknown_json_fields = {}
    end

    # @param [String] json_string The complete object in JSON format
    def from_json(json_string)
      from_hash(JSON.parse(json_string))
    end

    # @param [Hash] obj The complete object as a Ruby hash
    def from_hash(obj)
      obj.each do |k, v|
        case k
        when 'AccountID'
          raise TypeError 'expected string' unless v.is_a? String

          @account_id = v
        when 'Key'
          raise TypeError 'expected string' unless v.is_a? String

          @key = v
        when 'Bucket'
          raise TypeError 'expected string' unless v.is_a? String

          @bucket = v
        when 'Prefix'
          raise TypeError 'expected string' unless v.is_a? String

          @prefix = v
        when 'MaxConnections'
          @max_connections = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      unless @account_id.nil?
        ret['AccountID'] = @account_id
      end
      unless @key.nil?
        ret['Key'] = @key
      end
      unless @bucket.nil?
        ret['Bucket'] = @bucket
      end
      unless @prefix.nil?
        ret['Prefix'] = @prefix
      end
      unless @max_connections.nil?
        ret['MaxConnections'] = @max_connections
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
