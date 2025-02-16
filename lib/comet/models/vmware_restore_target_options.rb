# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # VMwareRestoreTargetOptions is a typed class wrapper around the underlying Comet Server API data structure.
  # VMwareRestoreTargetOptions is used when restoring a virtual machine backup job into VMware, using
# the RESTORETYPE_VMHOST option.
  # This type is available in Comet 24.12.x and later.
  class VMwareRestoreTargetOptions

    # The name of the VMware Datacenter to restore into. If blank and there is only one Datacenter in
    # the vSphere connection, it is chosen.
    # @type [String] datacenter
    attr_accessor :datacenter

    # The name of the VMware Host within the VMware Datacenter to restore into. If blank and there is
    # only one Datacenter in the vSphere connection, it is chosen.
    # @type [String] host
    attr_accessor :host

    # The name of the VMware Datastore on the VMware Host to restore into. If blank and there is only
    # one Datacenter in the vSphere connection, it is chosen.
    # @type [String] datastore_path
    attr_accessor :datastore_path

    # The name of the VMware Network on the VMware Host to restore into. If blank and there is only one
    # network on the target vSphere connection, it is chosen.
    # @type [String] network
    attr_accessor :network

    # @type [Comet::VMwareConnection] connection
    attr_accessor :connection

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @datacenter = ''
      @host = ''
      @datastore_path = ''
      @network = ''
      @connection = Comet::VMwareConnection.new
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
        when 'Datacenter'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @datacenter = v
        when 'Host'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @host = v
        when 'DatastorePath'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @datastore_path = v
        when 'Network'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @network = v
        when 'Connection'
          @connection = Comet::VMwareConnection.new
          @connection.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Datacenter'] = @datacenter
      ret['Host'] = @host
      ret['DatastorePath'] = @datastore_path
      ret['Network'] = @network
      ret['Connection'] = @connection
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
