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

    # @type [Number] size
    attr_accessor :size

    # @type [Array<Comet::Partition>] partitions
    attr_accessor :partitions

    # @type [Number] flags
    attr_accessor :flags

    # @type [Number] cylinders
    attr_accessor :cylinders

    # @type [Number] heads
    attr_accessor :heads

    # @type [Number] sectors
    attr_accessor :sectors

    # @type [Number] sector_size
    attr_accessor :sector_size

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @id = ""
      @device_name = ""
      @caption = ""
      @model = ""
      @serial_number = ""
      @size = ""
      @partitions = []
      @flags = ""
      @cylinders = ""
      @heads = ""
      @sectors = ""
      @sector_size = ""
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
        when 'ID'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @id = v
        when 'DeviceName'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @device_name = v
        when 'Caption'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @caption = v
        when 'Model'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @model = v
        when 'SerialNumber'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @serial_number = v
        when 'Size'
          raise TypeError "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

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
        when 'Flags'
          raise TypeError "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @flags = v
        when 'Cylinders'
          raise TypeError "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @cylinders = v
        when 'Heads'
          raise TypeError "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @heads = v
        when 'Sectors'
          raise TypeError "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @sectors = v
        when 'SectorSize'
          raise TypeError "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @sector_size = v
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
      ret['Flags'] = @flags
      ret['Cylinders'] = @cylinders
      ret['Heads'] = @heads
      ret['Sectors'] = @sectors
      ret['SectorSize'] = @sector_size
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
