#!/usr/bin/env ruby --enable-frozen-string-literal
#
# Copyright (c) 2020-2022 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT
#
# frozen_string_literal: true

require 'json'

module Comet

  # StorageRoleOptions is a typed class wrapper around the underlying Comet Server API data structure.
  class StorageRoleOptions

    # @type [Boolean] role_enabled
    attr_accessor :role_enabled

    # @type [Comet::DestinationLocation] storage
    attr_accessor :storage

    # @type [Array<Comet::LocalStorageDirectory>] local_storage__legacy
    attr_accessor :local_storage__legacy

    # @type [Array<Comet::ReplicaServer>] replicate_to
    attr_accessor :replicate_to

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @storage = Comet::DestinationLocation.new
      @local_storage__legacy = []
      @replicate_to = []
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
        when 'RoleEnabled'
          @role_enabled = v
        when 'Storage'
          @storage = Comet::DestinationLocation.new
          @storage.from_hash(v)
        when 'LocalStorage'
          if v.nil?
            @local_storage__legacy = []
          else
            @local_storage__legacy = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @local_storage__legacy[i1] = Comet::LocalStorageDirectory.new
              @local_storage__legacy[i1].from_hash(v1)
            end
          end
        when 'ReplicateTo'
          if v.nil?
            @replicate_to = []
          else
            @replicate_to = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @replicate_to[i1] = Comet::ReplicaServer.new
              @replicate_to[i1].from_hash(v1)
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
      ret['RoleEnabled'] = @role_enabled
      ret['Storage'] = @storage
      unless @local_storage__legacy.nil?
        ret['LocalStorage'] = @local_storage__legacy
      end
      ret['ReplicateTo'] = @replicate_to
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