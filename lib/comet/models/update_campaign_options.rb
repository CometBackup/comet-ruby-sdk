# frozen_string_literal: true

# Copyright (c) 2020-2022 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # UpdateCampaignOptions is a typed class wrapper around the underlying Comet Server API data structure.
  # This data structure describes which devices should receive a remote software upgrade. Both the
# target version criteria (UpgradeOlder/ReinstallCurrentVer/DowngradeNewer) and the target device
# criteria (ApplyDeviceFilter/DeviceFilter) must be met in order for the remote upgrade to be applied.
  class UpdateCampaignOptions

    # @type [Boolean] active
    attr_accessor :active

    # @type [Boolean] upgrade_older
    attr_accessor :upgrade_older

    # @type [Boolean] reinstall_current_ver
    attr_accessor :reinstall_current_ver

    # @type [Boolean] downgrade_newer
    attr_accessor :downgrade_newer

    # @type [Boolean] force_upgrade_running
    attr_accessor :force_upgrade_running

    # @type [Boolean] apply_device_filter
    attr_accessor :apply_device_filter

    # @type [Comet::SearchClause] device_filter
    attr_accessor :device_filter

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @device_filter = Comet::SearchClause.new
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
        when 'Active'
          @active = v
        when 'UpgradeOlder'
          @upgrade_older = v
        when 'ReinstallCurrentVer'
          @reinstall_current_ver = v
        when 'DowngradeNewer'
          @downgrade_newer = v
        when 'ForceUpgradeRunning'
          @force_upgrade_running = v
        when 'ApplyDeviceFilter'
          @apply_device_filter = v
        when 'DeviceFilter'
          @device_filter = Comet::SearchClause.new
          @device_filter.from_hash(v)
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
      ret['ForceUpgradeRunning'] = @force_upgrade_running
      ret['ApplyDeviceFilter'] = @apply_device_filter
      ret['DeviceFilter'] = @device_filter
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
