# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # PVERestoreSelection is a typed class wrapper around the underlying Comet Server API data structure.
  class PVERestoreSelection

    # @type [String] id
    attr_accessor :id

    # @type [String] name
    attr_accessor :name

    # @type [Comet::PVEVM] target_vm
    attr_accessor :target_vm

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @id = ''
      @name = ''
      @target_vm = Comet::PVEVM.new
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

          @name = v
        when 'TargetVM'
          @target_vm = Comet::PVEVM.new
          @target_vm.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      unless @id.nil?
        ret['ID'] = @id
      end
      unless @name.nil?
        ret['Name'] = @name
      end
      ret['TargetVM'] = @target_vm
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
