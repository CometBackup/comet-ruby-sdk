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

  # UpdateCampaignStatus is a typed class wrapper around the underlying Comet Server API data structure.
  class UpdateCampaignStatus

    # @type [Boolean] active
    attr_accessor :active

    # @type [Boolean] upgrade_older
    attr_accessor :upgrade_older

    # @type [Boolean] reinstall_current_ver
    attr_accessor :reinstall_current_ver

    # @type [Boolean] downgrade_newer
    attr_accessor :downgrade_newer

    # @type [Number] start_time
    attr_accessor :start_time

    # @type [String] target_version
    attr_accessor :target_version

    # @type [Array<Comet::UpdateCampaignStatusDeviceEntry>] devices
    attr_accessor :devices

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @start_time = 0
      @target_version = ''
      @devices = []
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
        when 'Active'
          @active = v
        when 'UpgradeOlder'
          @upgrade_older = v
        when 'ReinstallCurrentVer'
          @reinstall_current_ver = v
        when 'DowngradeNewer'
          @downgrade_newer = v
        when 'StartTime'
          raise TypeError "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @start_time = v
        when 'TargetVersion'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @target_version = v
        when 'Devices'
          if v.nil?
            @devices = []
          else
            @devices = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @devices[i1] = Comet::UpdateCampaignStatusDeviceEntry.new
              @devices[i1].from_hash(v1)
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
      ret['Active'] = @active
      ret['UpgradeOlder'] = @upgrade_older
      ret['ReinstallCurrentVer'] = @reinstall_current_ver
      ret['DowngradeNewer'] = @downgrade_newer
      ret['StartTime'] = @start_time
      ret['TargetVersion'] = @target_version
      ret['Devices'] = @devices
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
