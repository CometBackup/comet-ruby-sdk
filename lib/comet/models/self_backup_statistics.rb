# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # SelfBackupStatistics is a typed class wrapper around the underlying Comet Server API data structure.
  class SelfBackupStatistics

    # @type [Number] current_run_start
    attr_accessor :current_run_start

    # @type [Number] last_run_start
    attr_accessor :last_run_start

    # @type [Number] last_run_end
    attr_accessor :last_run_end

    # @type [Boolean] last_run_success
    attr_accessor :last_run_success

    # @type [Number] last_run_size
    attr_accessor :last_run_size

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @current_run_start = 0
      @last_run_start = 0
      @last_run_end = 0
      @last_run_size = 0
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
        when 'CurrentRunStart'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @current_run_start = v
        when 'LastRunStart'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @last_run_start = v
        when 'LastRunEnd'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @last_run_end = v
        when 'LastRunSuccess'
          @last_run_success = v
        when 'LastRunSize'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @last_run_size = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['CurrentRunStart'] = @current_run_start
      ret['LastRunStart'] = @last_run_start
      ret['LastRunEnd'] = @last_run_end
      ret['LastRunSuccess'] = @last_run_success
      ret['LastRunSize'] = @last_run_size
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
