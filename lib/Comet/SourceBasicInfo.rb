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

  # SourceBasicInfo is a typed class wrapper around the underlying Comet Server API data structure.
  class SourceBasicInfo

    # @type [String] description
    attr_accessor :description

    # @type [Number] size
    attr_accessor :size

    # @type [Hash{String => Comet::RetentionPolicy}] override_destination_retention
    attr_accessor :override_destination_retention

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      @override_destination_retention = {}
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
        when 'Description'
          raise TypeError 'expected string' unless v.is_a? String

          @description = v
        when 'Size'
          @size = v
        when 'OverrideDestinationRetention'
          @override_destination_retention = {}
          if v.nil?
            @override_destination_retention = {}
          else
            v.each do |k1, v1|
              @override_destination_retention[k1] = Comet::RetentionPolicy.new
              @override_destination_retention[k1].from_hash(v1)
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
      ret['Description'] = @description
      ret['Size'] = @size
      unless @override_destination_retention.nil?
        ret['OverrideDestinationRetention'] = @override_destination_retention
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
