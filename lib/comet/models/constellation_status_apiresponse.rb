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

  # ConstellationStatusAPIResponse is a typed class wrapper around the underlying Comet Server API data structure.
  class ConstellationStatusAPIResponse

    # @type [Boolean] deletion_enabled
    attr_accessor :deletion_enabled

    # @type [Array<String>] targets
    attr_accessor :targets

    # @type [Array<String>] target_names
    attr_accessor :target_names

    # @type [Comet::ConstellationStats] stats
    attr_accessor :stats

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      @targets = []
      @target_names = []
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
        when 'DeletionEnabled'
          @deletion_enabled = v
        when 'Targets'
          if v.nil?
            @targets = []
          else
            @targets = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @targets[i1] = v1
            end
          end
        when 'TargetNames'
          if v.nil?
            @target_names = []
          else
            @target_names = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @target_names[i1] = v1
            end
          end
        when 'Stats'
          @stats = Comet::ConstellationStats.new
          @stats.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['DeletionEnabled'] = @deletion_enabled
      ret['Targets'] = @targets
      unless @target_names.nil?
        ret['TargetNames'] = @target_names
      end
      ret['Stats'] = @stats
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
