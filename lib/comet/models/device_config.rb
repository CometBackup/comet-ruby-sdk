# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # DeviceConfig is a typed class wrapper around the underlying Comet Server API data structure.
  class DeviceConfig

    # @type [String] friendly_name
    attr_accessor :friendly_name

    # Unix timestamp in seconds
    # @type [Number] registration_time
    attr_accessor :registration_time

    # The operating system that the device uses.
    # @type [Comet::OSInfo] platform_version
    attr_accessor :platform_version

    # Minimal information about the device's private Protected Items, so that other devices can safely
    # run retention passes on a shared Storage Vault.
    # @type [Hash{String => Comet::SourceBasicInfo}] sources
    attr_accessor :sources

    # The device's reported timezone in IANA format.
    # @type [String] device_timezone
    attr_accessor :device_timezone

    # This field is available in Comet 23.6.0 and later.
    # @type [String] client_version
    attr_accessor :client_version

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @friendly_name = ''
      @registration_time = 0
      @platform_version = Comet::OSInfo.new
      @sources = {}
      @device_timezone = ''
      @client_version = ''
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
        when 'FriendlyName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @friendly_name = v
        when 'RegistrationTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @registration_time = v
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
        when 'DeviceTimezone'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @device_timezone = v
        when 'ClientVersion'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @client_version = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['FriendlyName'] = @friendly_name
      unless @registration_time.nil?
        ret['RegistrationTime'] = @registration_time
      end
      unless @platform_version.nil?
        ret['PlatformVersion'] = @platform_version
      end
      unless @sources.nil?
        ret['Sources'] = @sources
      end
      unless @device_timezone.nil?
        ret['DeviceTimezone'] = @device_timezone
      end
      unless @client_version.nil?
        ret['ClientVersion'] = @client_version
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
