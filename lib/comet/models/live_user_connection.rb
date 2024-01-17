# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # LiveUserConnection is a typed class wrapper around the underlying Comet Server API data structure.
  class LiveUserConnection

    # @type [String] username
    attr_accessor :username

    # @type [String] device_id
    attr_accessor :device_id

    # The Comet Backup software version that this live-connected device reports that it is running. It
    # takes the format "MAJOR.MINOR.PATCH", such as "23.2.0". See the APPLICATION_VERSION constant for
    # more information.
    # @type [String] reported_version
    attr_accessor :reported_version

    # The operating system of the device. It is one of the PLATFORM_ constants; then a forwardslash (/);
    # then the device's GOARCH.
    # @type [String] reported_platform
    attr_accessor :reported_platform

    # The operating system of the device, in extended detail.
    # @type [Comet::OSInfo] reported_platform_version
    attr_accessor :reported_platform_version

    # The reported timezone of the device, in IANA format.
    # @type [String] device_time_zone
    attr_accessor :device_time_zone

    # The live-connected device's remote IP address, as seen from the Comet Server.
    # @type [String] ipaddress
    attr_accessor :ipaddress

    # Unix timestamp, in seconds.
    # @type [Number] connection_time
    attr_accessor :connection_time

    # The current state of the "Allow administrator to view my files" client-side option. If this option
    # is refused, some live-connected actions will be refused by the device.
    # @type [Boolean] allows_filenames
    attr_accessor :allows_filenames

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @username = ''
      @device_id = ''
      @reported_version = ''
      @reported_platform = ''
      @reported_platform_version = Comet::OSInfo.new
      @device_time_zone = ''
      @ipaddress = ''
      @connection_time = 0
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
        when 'Username'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @username = v
        when 'DeviceID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @device_id = v
        when 'ReportedVersion'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @reported_version = v
        when 'ReportedPlatform'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @reported_platform = v
        when 'ReportedPlatformVersion'
          @reported_platform_version = Comet::OSInfo.new
          @reported_platform_version.from_hash(v)
        when 'DeviceTimeZone'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @device_time_zone = v
        when 'IPAddress'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @ipaddress = v
        when 'ConnectionTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @connection_time = v
        when 'AllowsFilenames'
          @allows_filenames = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Username'] = @username
      ret['DeviceID'] = @device_id
      ret['ReportedVersion'] = @reported_version
      ret['ReportedPlatform'] = @reported_platform
      unless @reported_platform_version.nil?
        ret['ReportedPlatformVersion'] = @reported_platform_version
      end
      unless @device_time_zone.nil?
        ret['DeviceTimeZone'] = @device_time_zone
      end
      unless @ipaddress.nil?
        ret['IPAddress'] = @ipaddress
      end
      ret['ConnectionTime'] = @connection_time
      ret['AllowsFilenames'] = @allows_filenames
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
