# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # HyperVMachineInfo is a typed class wrapper around the underlying Comet Server API data structure.
  class HyperVMachineInfo

    # @type [String] id
    attr_accessor :id

    # @type [String] display_name
    attr_accessor :display_name

    # This field is available in Comet 24.12.x and later.
    # @type [Number] memory_limit_mb
    attr_accessor :memory_limit_mb

    # This field is available in Comet 24.12.x and later.
    # @type [Number] cpucores
    attr_accessor :cpucores

    # This field is available in Comet 24.12.x and later.
    # @type [Array<String>] hard_drives
    attr_accessor :hard_drives

    # This field is available in Comet 24.12.x and later.
    # @type [Number] generation
    attr_accessor :generation

    # This field is available in Comet 24.12.x and later.
    # @type [String] config_file_path
    attr_accessor :config_file_path

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @id = ''
      @display_name = ''
      @memory_limit_mb = 0
      @cpucores = 0
      @hard_drives = []
      @generation = 0
      @config_file_path = ''
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
        when 'Name'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @display_name = v
        when 'MemoryLimitMB'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @memory_limit_mb = v
        when 'CPUCores'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @cpucores = v
        when 'HardDrives'
          if v.nil?
            @hard_drives = []
          else
            @hard_drives = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @hard_drives[i1] = v1
            end
          end
        when 'Generation'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @generation = v
        when 'ConfigFilePath'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @config_file_path = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['ID'] = @id
      ret['Name'] = @display_name
      ret['MemoryLimitMB'] = @memory_limit_mb
      ret['CPUCores'] = @cpucores
      ret['HardDrives'] = @hard_drives
      ret['Generation'] = @generation
      ret['ConfigFilePath'] = @config_file_path
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
