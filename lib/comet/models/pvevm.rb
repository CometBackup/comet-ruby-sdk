# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # PVEVM is a typed class wrapper around the underlying Comet Server API data structure.
  # PVEVM describes a single Proxmox virtual machine or container.
  class PVEVM

    # @type [String] cpu
    attr_accessor :cpu

    # @type [Array<Comet::PVEDisk>] disks
    attr_accessor :disks

    # @type [String] memory
    attr_accessor :memory

    # @type [String] name
    attr_accessor :name

    # @type [String] node
    attr_accessor :node

    # @type [String] ostype
    attr_accessor :ostype

    # @type [Boolean] running
    attr_accessor :running

    # @type [String] type
    attr_accessor :type

    # String type, but always contains an integer value
    # @type [String] vmid
    attr_accessor :vmid

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @cpu = ''
      @disks = []
      @memory = ''
      @name = ''
      @node = ''
      @ostype = ''
      @type = ''
      @vmid = ''
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
        when 'CPU'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @cpu = v
        when 'Disks'
          if v.nil?
            @disks = []
          else
            @disks = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @disks[i1] = Comet::PVEDisk.new
              @disks[i1].from_hash(v1)
            end
          end
        when 'Memory'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @memory = v
        when 'Name'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @name = v
        when 'Node'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @node = v
        when 'OSType'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @ostype = v
        when 'Running'
          @running = v
        when 'Type'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @type = v
        when 'VMID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @vmid = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['CPU'] = @cpu
      ret['Disks'] = @disks
      ret['Memory'] = @memory
      ret['Name'] = @name
      ret['Node'] = @node
      ret['OSType'] = @ostype
      ret['Running'] = @running
      ret['Type'] = @type
      ret['VMID'] = @vmid
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
