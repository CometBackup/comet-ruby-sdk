# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # ContentMeasurementComponent is a typed class wrapper around the underlying Comet Server API data structure.
  class ContentMeasurementComponent

    # @type [Number] bytes
    attr_accessor :bytes

    # A list of strings describing which groups of snapshots rely on reaching this component of data.
    # The strings may take the following formats:
    # - source_id/CURRENT - this data is required by the most recent backup job snapshot for the listed
    # Protected Item source.
    # - source_id/HISTORIC - this data is required by an older backup job snapshot for the listed
    # Protected Item source.
    # - TRUNCATED/* - there are too many separate components to show, and this component represents data
    # that is used by some other combination of components. If present, it will be the only entry in the
    # UsedBy array.
    # - the empty string - this amount of data is not currently referenced by any backup job snapshots.
    # If that remains the case by the next retention pass, this much data will be deleted to free up
    # space. If present, it will be the only entry in the UsedBy array.
    # @type [Array<String>] used_by
    attr_accessor :used_by

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @bytes = 0
      @used_by = []
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
        when 'Bytes'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @bytes = v
        when 'UsedBy'
          if v.nil?
            @used_by = []
          else
            @used_by = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @used_by[i1] = v1
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
      ret['Bytes'] = @bytes
      ret['UsedBy'] = @used_by
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
