# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # LicenseLimits is a typed class wrapper around the underlying Comet Server API data structure.
  class LicenseLimits

    # @type [Number] device_count
    attr_accessor :device_count

    # @type [Hash{String => Number}] booster_count
    attr_accessor :booster_count

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @device_count = 0
      @booster_count = {}
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
        when 'deviceCount'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @device_count = v
        when 'boosterCount'
          @booster_count = {}
          if v.nil?
            @booster_count = {}
          else
            v.each do |k1, v1|
              raise TypeError, "'v1' expected Numeric, got #{v1.class}" unless v1.is_a? Numeric

              @booster_count[k1] = v1
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
      unless @device_count.nil?
        ret['deviceCount'] = @device_count
      end
      unless @booster_count.nil?
        ret['boosterCount'] = @booster_count
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
