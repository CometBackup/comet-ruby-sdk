# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # BrowseHVResponse is a typed class wrapper around the underlying Comet Server API data structure.
  class BrowseHVResponse

    # If the operation was successful, the status will be in the 200-299 range.
    # @type [Number] status
    attr_accessor :status

    # @type [String] message
    attr_accessor :message

    # @type [Array<Comet::HyperVMachineInfo>] virtual_machines
    attr_accessor :virtual_machines

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @status = 0
      @message = ''
      @virtual_machines = []
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
        when 'VirtualMachines'
          if v.nil?
            @virtual_machines = []
          else
            @virtual_machines = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @virtual_machines[i1] = Comet::HyperVMachineInfo.new
              @virtual_machines[i1].from_hash(v1)
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
      ret['VirtualMachines'] = @virtual_machines
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
