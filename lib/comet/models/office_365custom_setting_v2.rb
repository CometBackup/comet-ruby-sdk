# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # Office365CustomSettingV2 is a typed class wrapper around the underlying Comet Server API data structure.
  class Office365CustomSettingV2

    # @type [Boolean] organization
    attr_accessor :organization

    # @type [Hash{String => Number}] backup_options
    attr_accessor :backup_options

    # @type [Hash{String => Number}] member_backup_options
    attr_accessor :member_backup_options

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @backup_options = {}
      @member_backup_options = {}
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
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Organization'] = @organization
      unless @backup_options.nil?
        ret['BackupOptions'] = @backup_options
      end
      unless @member_backup_options.nil?
        ret['MemberBackupOptions'] = @member_backup_options
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
