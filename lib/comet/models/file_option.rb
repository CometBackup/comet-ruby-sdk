# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # FileOption is a typed class wrapper around the underlying Comet Server API data structure.
  # FileOption defines the configuration for Comet Server to log live events to a file. See the SEVT_
# constants for more information.
  # This type is available in Comet 23.3.7 and later.
  class FileOption

    # The prefix for the log filename. It will be stored in the same file location as the Comet Server
    # log files
    # @type [String] filename
    attr_accessor :filename

    # Configure a subset of allowed event types (see SEVT_ constants). If the array is empty, all events
    # will be sent
    # @type [Array<Number>] allow_event_types
    attr_accessor :allow_event_types

    # One of the STREAM_LEVEL_ constants. This controls how much data is logged into the file
    # @type [String] level
    attr_accessor :level

    # Enables pruning of log files
    # @type [Boolean] pruning_enabled
    attr_accessor :pruning_enabled

    # Limit in days to keep log files when PruningEnabled is set to true. If not set or 0, uses server's
    # PruneLogsAfterDays
    # @type [Number] pruning_limit
    attr_accessor :pruning_limit

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @filename = ''
      @allow_event_types = []
      @level = ''
      @pruning_limit = 0
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
        when 'Filename'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @filename = v
        when 'AllowEventTypes'
          if v.nil?
            @allow_event_types = []
          else
            @allow_event_types = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected Numeric, got #{v1.class}" unless v1.is_a? Numeric

              @allow_event_types[i1] = v1
            end
          end
        when 'Level'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @level = v
        when 'PruningEnabled'
          @pruning_enabled = v
        when 'PruningLimit'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @pruning_limit = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Filename'] = @filename
      unless @allow_event_types.nil?
        ret['AllowEventTypes'] = @allow_event_types
      end
      unless @level.nil?
        ret['Level'] = @level
      end
      unless @pruning_enabled.nil?
        ret['PruningEnabled'] = @pruning_enabled
      end
      unless @pruning_limit.nil?
        ret['PruningLimit'] = @pruning_limit
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
