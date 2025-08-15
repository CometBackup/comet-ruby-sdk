# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # PVEBackupNode is a typed class wrapper around the underlying Comet Server API data structure.
  class PVEBackupNode

    # @type [Array<Comet::PVEBackupVM>] included_vms
    attr_accessor :included_vms

    # @type [String] name
    attr_accessor :name

    # @type [Boolean] selected
    attr_accessor :selected

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @included_vms = []
      @name = ''
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
        when 'IncludedVMs'
          if v.nil?
            @included_vms = []
          else
            @included_vms = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @included_vms[i1] = Comet::PVEBackupVM.new
              @included_vms[i1].from_hash(v1)
            end
          end
        when 'Name'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @name = v
        when 'Selected'
          @selected = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      unless @included_vms.nil?
        ret['IncludedVMs'] = @included_vms
      end
      unless @name.nil?
        ret['Name'] = @name
      end
      unless @selected.nil?
        ret['Selected'] = @selected
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
