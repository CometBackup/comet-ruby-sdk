#!/usr/bin/env ruby --enable-frozen-string-literal
#
# Copyright (c) 2020-2021 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT
#
# frozen_string_literal: true

require 'json'

module Comet

  # SpannedDestinationLocation is a typed class wrapper around the underlying Comet Server API data structure.
  class SpannedDestinationLocation

    # @type [Array<Comet::DestinationLocation>] span_targets
    attr_accessor :span_targets

    # @type [Boolean] span_use_static_slots
    attr_accessor :span_use_static_slots

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @span_targets = []
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
        when 'SpanTargets'
          if v.nil?
            @span_targets = []
          else
            @span_targets = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @span_targets[i1] = Comet::DestinationLocation.new
              @span_targets[i1].from_hash(v1)
            end
          end
        when 'SpanUseStaticSlots'
          @span_use_static_slots = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['SpanTargets'] = @span_targets
      ret['SpanUseStaticSlots'] = @span_use_static_slots
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
