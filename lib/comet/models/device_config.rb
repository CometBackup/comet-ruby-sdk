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

  # DeviceConfig is a typed class wrapper around the underlying Comet Server API data structure.
  class DeviceConfig

    # @type [String] friendly_name
    attr_accessor :friendly_name

    # @type [Comet::OSInfo] platform_version
    attr_accessor :platform_version

    # @type [Hash{String => Comet::SourceBasicInfo}] sources
    attr_accessor :sources

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      @sources = {}
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
        when 'FriendlyName'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @friendly_name = v
        when 'PlatformVersion'
          @platform_version = Comet::OSInfo.new
          @platform_version.from_hash(v)
        when 'Sources'
          @sources = {}
          if v.nil?
            @sources = {}
          else
            v.each do |k1, v1|
              @sources[k1] = Comet::SourceBasicInfo.new
              @sources[k1].from_hash(v1)
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
      ret['FriendlyName'] = @friendly_name
      unless @platform_version.nil?
        ret['PlatformVersion'] = @platform_version
      end
      unless @sources.nil?
        ret['Sources'] = @sources
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
