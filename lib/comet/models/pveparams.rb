# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # PVEParams is a typed class wrapper around the underlying Comet Server API data structure.
  # This type is used in the EngineProps for an "engine1/proxmox" Protected Item. It represents the
# entire Protected Item configuration. It is expected to be user-configurable.
  # This type is available in Comet 25.8.0 and later.
  class PVEParams

    # @type [Boolean] everything
    attr_accessor :everything

    # @type [Array<Comet::PVEBackupNode>] exclusions
    attr_accessor :exclusions

    # One of the PVE_BACKUP_METHOD constants
    # @type [String] method
    attr_accessor :method

    # Primary node URL + SSH credentials
    # @type [Comet::SSHConnection] sshconnection
    attr_accessor :sshconnection

    # @type [Array<Comet::PVEBackupNode>] selections
    attr_accessor :selections

    # @type [Boolean] use_cbt
    attr_accessor :use_cbt

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @exclusions = []
      @method = ''
      @sshconnection = Comet::SSHConnection.new
      @selections = []
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
        when 'Everything'
          @everything = v
        when 'Exclusions'
          if v.nil?
            @exclusions = []
          else
            @exclusions = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @exclusions[i1] = Comet::PVEBackupNode.new
              @exclusions[i1].from_hash(v1)
            end
          end
        when 'Method'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @method = v
        when 'SSHConnection'
          @sshconnection = Comet::SSHConnection.new
          @sshconnection.from_hash(v)
        when 'Selections'
          if v.nil?
            @selections = []
          else
            @selections = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @selections[i1] = Comet::PVEBackupNode.new
              @selections[i1].from_hash(v1)
            end
          end
        when 'UseCBT'
          @use_cbt = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      unless @everything.nil?
        ret['Everything'] = @everything
      end
      unless @exclusions.nil?
        ret['Exclusions'] = @exclusions
      end
      unless @method.nil?
        ret['Method'] = @method
      end
      unless @sshconnection.nil?
        ret['SSHConnection'] = @sshconnection
      end
      unless @selections.nil?
        ret['Selections'] = @selections
      end
      unless @use_cbt.nil?
        ret['UseCBT'] = @use_cbt
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
