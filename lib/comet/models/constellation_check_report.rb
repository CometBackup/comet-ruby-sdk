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

  # ConstellationCheckReport is a typed class wrapper around the underlying Comet Server API data structure.
  class ConstellationCheckReport

    # @type [Number] check_started
    attr_accessor :check_started

    # @type [Number] check_completed
    attr_accessor :check_completed

    # @type [Hash{String => Comet::BucketUsageInfo}] usage
    attr_accessor :usage

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @check_started = 0
      @check_completed = 0
      @usage = {}
      @unknown_json_fields = {}
    end

    # @param [String] json_string The complete object in JSON format
    def from_json(json_string)
      raise TypeError "'json_string' expected String, got #{json_string.class}" unless json_string.is_a? String

      from_hash(JSON.parse(json_string))
    end

    # @param [Hash] obj The complete object as a Ruby hash
    def from_hash(obj)
      raise TypeError "'obj' expected Hash, got #{obj.class}" unless obj.is_a? Hash

      obj.each do |k, v|
        case k
        when 'CheckStarted'
          raise TypeError "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @check_started = v
        when 'CheckCompleted'
          raise TypeError "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @check_completed = v
        when 'Usage'
          @usage = {}
          if v.nil?
            @usage = {}
          else
            v.each do |k1, v1|
              @usage[k1] = Comet::BucketUsageInfo.new
              @usage[k1].from_hash(v1)
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
      ret['CheckStarted'] = @check_started
      ret['CheckCompleted'] = @check_completed
      ret['Usage'] = @usage
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
