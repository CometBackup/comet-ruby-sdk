# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # Partition is a typed class wrapper around the underlying Comet Server API data structure.
  class Partition

    # @type [String] device_name
    attr_accessor :device_name

    # The name of the filesystem used on this partition (e.g. "NTFS")
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

    # Bytes. The partition's offset within the DeviceName. It will be zero if this partition has a
    # direct DeviceName handle.
    # @type [Number] read_offset
    attr_accessor :read_offset

    # Bytes
    # @type [Number] size
    attr_accessor :size

    # Bytes. Only present for supported filesystems that are currently mounted by the OS
    # @type [Number] used_size
    attr_accessor :used_size

    # @type [Number] flags
    attr_accessor :flags

    # @type [Number] bytes_per_filesystem_cluster
    attr_accessor :bytes_per_filesystem_cluster

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @device_name = ''
      @filesystem = ''
      @volume_name = ''
      @volume_guid = ''
      @volume_serial = ''
      @mount_points = []
      @read_offset = 0
      @size = 0
      @used_size = 0
      @flags = 0
      @bytes_per_filesystem_cluster = 0
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
        when 'DeviceName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @device_name = v
        when 'Filesystem'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @filesystem = v
        when 'VolumeName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @volume_name = v
        when 'VolumeGuid'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @volume_guid = v
        when 'VolumeSerial'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @volume_serial = v
        when 'MountPoints'
          if v.nil?
            @mount_points = []
          else
            @mount_points = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @mount_points[i1] = v1
            end
          end
        when 'ReadOffset'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @read_offset = v
        when 'Size'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @size = v
        when 'UsedSize'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @used_size = v
        when 'Flags'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @flags = v
        when 'BytesPerFilesystemCluster'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

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
