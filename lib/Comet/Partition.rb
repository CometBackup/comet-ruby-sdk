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

  # Partition is a typed class wrapper around the underlying Comet Server API data structure.
  class Partition

    # @type [String] device_name
    attr_accessor :device_name

    # @type [String] filesystem
    attr_accessor :filesystem

    # @type [String] volume_name
    attr_accessor :volume_name

    # @type [String] volume_guid
    attr_accessor :volume_guid

    # @type [String] volume_serial
    attr_accessor :volume_serial

    # @type [Array<String>] mount_points
    attr_accessor :mount_points

    # @type [Number] read_offset
    attr_accessor :read_offset

    # @type [Number] size
    attr_accessor :size

    # @type [Number] used_size
    attr_accessor :used_size

    # @type [Number] flags
    attr_accessor :flags

    # @type [Number] bytes_per_filesystem_cluster
    attr_accessor :bytes_per_filesystem_cluster

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      @mount_points = []
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
        when 'DeviceName'
          raise TypeError 'expected string' unless v.is_a? String

          @device_name = v
        when 'Filesystem'
          raise TypeError 'expected string' unless v.is_a? String

          @filesystem = v
        when 'VolumeName'
          raise TypeError 'expected string' unless v.is_a? String

          @volume_name = v
        when 'VolumeGuid'
          raise TypeError 'expected string' unless v.is_a? String

          @volume_guid = v
        when 'VolumeSerial'
          raise TypeError 'expected string' unless v.is_a? String

          @volume_serial = v
        when 'MountPoints'
          if v.nil?
            @mount_points = []
          else
            @mount_points = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError 'expected string' unless v1.is_a? String

              @mount_points[i1] = v1
            end
          end
        when 'ReadOffset'
          @read_offset = v
        when 'Size'
          @size = v
        when 'UsedSize'
          @used_size = v
        when 'Flags'
          @flags = v
        when 'BytesPerFilesystemCluster'
          @bytes_per_filesystem_cluster = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['DeviceName'] = @device_name
      ret['Filesystem'] = @filesystem
      ret['VolumeName'] = @volume_name
      ret['VolumeGuid'] = @volume_guid
      ret['VolumeSerial'] = @volume_serial
      ret['MountPoints'] = @mount_points
      ret['ReadOffset'] = @read_offset
      ret['Size'] = @size
      ret['UsedSize'] = @used_size
      ret['Flags'] = @flags
      ret['BytesPerFilesystemCluster'] = @bytes_per_filesystem_cluster
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
