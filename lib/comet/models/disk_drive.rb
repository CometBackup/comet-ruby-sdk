# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # DiskDrive is a typed class wrapper around the underlying Comet Server API data structure.
  class DiskDrive

    # @type [String] id
    attr_accessor :id

    # @type [String] device_name
    attr_accessor :device_name

    # @type [String] caption
    attr_accessor :caption

    # @type [String] model
    attr_accessor :model

    # @type [String] serial_number
    attr_accessor :serial_number

    # Bytes
    # @type [Number] size
    attr_accessor :size

    # @type [Array<Comet::Partition>] partitions
    attr_accessor :partitions

    # For physical disks, this array will be empty. For virtual disks, RAID devices or Linux DM devices,
    # this array may contain the DeviceName of the parent device.
    # This field is available in Comet 24.6.x and later.
    # @type [Array<String>] device_parents
    attr_accessor :device_parents

    # See WINDISKFLAG_ constants
    # @type [Number] flags
    attr_accessor :flags

    # @type [Number] cylinders
    # @deprecated This member has been deprecated since Comet version 24.6.x This value is reported from the disk driver if available. Otherwise emulates a value based on modern LBA addressing. The field value is not used.
    attr_accessor :cylinders

    # @type [Number] heads
    # @deprecated This member has been deprecated since Comet version 24.6.x This value is reported from the disk driver if available. Otherwise emulates a value based on modern LBA addressing. The field value is not used.
    attr_accessor :heads

    # @type [Number] sectors
    # @deprecated This member has been deprecated since Comet version 24.6.x This value is reported from the disk driver if available. Otherwise emulates a value based on modern LBA addressing. The field value is not used.
    attr_accessor :sectors

    # @type [Number] sector_size
    attr_accessor :sector_size

    # Used to indicate the partition conflicts on the disk.
    # @type [Array<Comet::PartitionConflict>] partition_conflicts
    attr_accessor :partition_conflicts

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @id = ''
      @device_name = ''
      @caption = ''
      @model = ''
      @serial_number = ''
      @size = 0
      @partitions = []
      @device_parents = []
      @flags = 0
      @cylinders = 0
      @heads = 0
      @sectors = 0
      @sector_size = 0
      @partition_conflicts = []
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
        when 'ID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @id = v
        when 'DeviceName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @device_name = v
        when 'Caption'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @caption = v
        when 'Model'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @model = v
        when 'SerialNumber'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @serial_number = v
        when 'Size'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @size = v
        when 'Partitions'
          if v.nil?
            @partitions = []
          else
            @partitions = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @partitions[i1] = Comet::Partition.new
              @partitions[i1].from_hash(v1)
            end
          end
        when 'DeviceParents'
          if v.nil?
            @device_parents = []
          else
            @device_parents = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @device_parents[i1] = v1
            end
          end
        when 'Flags'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @flags = v
        when 'Cylinders'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @cylinders = v
        when 'Heads'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @heads = v
        when 'Sectors'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @sectors = v
        when 'SectorSize'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @sector_size = v
        when 'PartitionConflicts'
          if v.nil?
            @partition_conflicts = []
          else
            @partition_conflicts = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @partition_conflicts[i1] = Comet::PartitionConflict.new
              @partition_conflicts[i1].from_hash(v1)
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
      ret['ID'] = @id
      ret['DeviceName'] = @device_name
      ret['Caption'] = @caption
      ret['Model'] = @model
      ret['SerialNumber'] = @serial_number
      ret['Size'] = @size
      ret['Partitions'] = @partitions
      ret['DeviceParents'] = @device_parents
      ret['Flags'] = @flags
      ret['Cylinders'] = @cylinders
      ret['Heads'] = @heads
      ret['Sectors'] = @sectors
      ret['SectorSize'] = @sector_size
      ret['PartitionConflicts'] = @partition_conflicts
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
