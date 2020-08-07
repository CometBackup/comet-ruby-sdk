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

  # StorageFreeSpaceInfo is a typed class wrapper around the underlying Comet Server API data structure.
  class StorageFreeSpaceInfo

    # @type [Boolean] unlimited
    attr_accessor :unlimited

    # @type [Number] used_percent
    attr_accessor :used_percent

    # @type [Number] available_bytes
    attr_accessor :available_bytes

    # @type [Comet::SpannedStorageExtraInfo] spanned
    attr_accessor :spanned

    # @type [Comet::B2StorageExtraInfo] b2
    attr_accessor :b2

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
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
        when 'Unlimited'
          @unlimited = v
        when 'UsedPercent'
          @used_percent = v
        when 'AvailableBytes'
          @available_bytes = v
        when 'Spanned'
          @spanned = Comet::SpannedStorageExtraInfo.new
          @spanned.from_hash(v)
        when 'B2'
          @b2 = Comet::B2StorageExtraInfo.new
          @b2.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Unlimited'] = @unlimited
      ret['UsedPercent'] = @used_percent
      ret['AvailableBytes'] = @available_bytes
      unless @spanned.nil?
        ret['Spanned'] = @spanned
      end
      unless @b2.nil?
        ret['B2'] = @b2
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
