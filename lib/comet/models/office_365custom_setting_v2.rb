# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # Office365CustomSettingV2 is a typed class wrapper around the underlying Comet Server API data structure.
  # Office365CustomSettingV2 is used in the EngineProps for an Office 365 Protected Item (see
# ENGINE_BUILTIN_MSOFFICE).
  # This type is available in Comet 21.9.xx and later.
  class Office365CustomSettingV2

    # If true, then backup everything except the selected users (group members are still included)
    # @type [Boolean] organization
    # @deprecated This member has been deprecated since Comet version 24.12.2
    attr_accessor :organization

    # If true, exclude all filtered IDs and Members. Backup everything else
    # @type [Boolean] filter_mode
    attr_accessor :filter_mode

    # If true, backup everything, ignoring selection and filter options
    # @type [Boolean] whole_org
    attr_accessor :whole_org

    # Key is the ID of User, Group, or Site
    # Value is a bitset of the SERVICE_ constants, to select which services to backup for accounts
    # @type [Hash{String => Number}] backup_options
    attr_accessor :backup_options

    # Key is the ID of a Group or Team Site
    # Value is a bitset of the SERVICE_ constants, to select which services to backup for members
    # @type [Hash{String => Number}] member_backup_options
    attr_accessor :member_backup_options

    # Key is the ID of a User, Group, or Site
    # Value is a bitset of the SERVICE_ constants, to select which services to not backup for accounts
    # @type [Hash{String => Number}] filter_options
    attr_accessor :filter_options

    # Key is the ID of a Group or Team Site
    # Value is a bitset of the SERVICE_ constants, to select which services to not backup for members
    # @type [Hash{String => Number}] filter_member_options
    attr_accessor :filter_member_options

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @backup_options = {}
      @member_backup_options = {}
      @filter_options = {}
      @filter_member_options = {}
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
        when 'Organization'
          @organization = v
        when 'FilterMode'
          @filter_mode = v
        when 'WholeOrg'
          @whole_org = v
        when 'BackupOptions'
          @backup_options = {}
          if v.nil?
            @backup_options = {}
          else
            v.each do |k1, v1|
              raise TypeError, "'v1' expected Numeric, got #{v1.class}" unless v1.is_a? Numeric

              @backup_options[k1] = v1
            end
          end
        when 'MemberBackupOptions'
          @member_backup_options = {}
          if v.nil?
            @member_backup_options = {}
          else
            v.each do |k1, v1|
              raise TypeError, "'v1' expected Numeric, got #{v1.class}" unless v1.is_a? Numeric

              @member_backup_options[k1] = v1
            end
          end
        when 'FilterOptions'
          @filter_options = {}
          if v.nil?
            @filter_options = {}
          else
            v.each do |k1, v1|
              raise TypeError, "'v1' expected Numeric, got #{v1.class}" unless v1.is_a? Numeric

              @filter_options[k1] = v1
            end
          end
        when 'FilterMemberOptions'
          @filter_member_options = {}
          if v.nil?
            @filter_member_options = {}
          else
            v.each do |k1, v1|
              raise TypeError, "'v1' expected Numeric, got #{v1.class}" unless v1.is_a? Numeric

              @filter_member_options[k1] = v1
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
      ret['Organization'] = @organization
      unless @filter_mode.nil?
        ret['FilterMode'] = @filter_mode
      end
      unless @whole_org.nil?
        ret['WholeOrg'] = @whole_org
      end
      unless @backup_options.nil?
        ret['BackupOptions'] = @backup_options
      end
      unless @member_backup_options.nil?
        ret['MemberBackupOptions'] = @member_backup_options
      end
      unless @filter_options.nil?
        ret['FilterOptions'] = @filter_options
      end
      unless @filter_member_options.nil?
        ret['FilterMemberOptions'] = @filter_member_options
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
