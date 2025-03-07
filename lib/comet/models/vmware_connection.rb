# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # VMwareConnection is a typed class wrapper around the underlying Comet Server API data structure.
  class VMwareConnection

    # One of the VMWARE_CONNECTION_ constants
    # @type [String] connection_type
    attr_accessor :connection_type

    # @type [Comet::SSHConnection] ssh
    # @deprecated This member has been deprecated since Comet version 23.9.11
    attr_accessor :ssh

    # @type [Comet::VSphereConnection] vsphere
    attr_accessor :vsphere

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @connection_type = ''
      @ssh = Comet::SSHConnection.new
      @vsphere = Comet::VSphereConnection.new
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
        when 'ConnectionType'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @connection_type = v
        when 'SSH'
          @ssh = Comet::SSHConnection.new
          @ssh.from_hash(v)
        when 'VSphere'
          @vsphere = Comet::VSphereConnection.new
          @vsphere.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['ConnectionType'] = @connection_type
      ret['SSH'] = @ssh
      ret['VSphere'] = @vsphere
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
