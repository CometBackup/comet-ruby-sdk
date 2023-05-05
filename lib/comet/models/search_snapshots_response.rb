# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # SearchSnapshotsResponse is a typed class wrapper around the underlying Comet Server API data structure.
  class SearchSnapshotsResponse

    # If the operation was successful, the status will be in the 200-299 range.
    # @type [Number] status
    attr_accessor :status

    # @type [String] message
    attr_accessor :message

    # @type [Hash{String => Array<Comet::SearchResultFileInfo>}] snapshot_files
    attr_accessor :snapshot_files

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @status = 0
      @message = ''
      @snapshot_files = {}
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
        when 'Status'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @status = v
        when 'Message'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @message = v
        when 'SnapshotFiles'
          @snapshot_files = {}
          if v.nil?
            @snapshot_files = {}
          else
            v.each do |k1, v1|
              if v1.nil?
                @snapshot_files[k1] = []
              else
                @snapshot_files[k1] = Array.new(v1.length)
                v1.each_with_index do |v2, i2|
                  @snapshot_files[k1][i2] = Comet::SearchResultFileInfo.new
                  @snapshot_files[k1][i2].from_hash(v2)
                end
              end
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
      ret['Status'] = @status
      ret['Message'] = @message
      ret['SnapshotFiles'] = @snapshot_files
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