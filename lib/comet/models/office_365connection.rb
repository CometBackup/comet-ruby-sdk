#!/usr/bin/env ruby --enable-frozen-string-literal
#
# Copyright (c) 2020-2021 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT
#
# frozen_string_literal: true

require 'json'

module Comet

  # Office365Connection is a typed class wrapper around the underlying Comet Server API data structure.
  class Office365Connection

    # @type [String] feature_flag
    attr_accessor :feature_flag

    # @type [Comet::Office365Credential] credential
    attr_accessor :credential

    # @type [Comet::Office365CustomSetting] custom_setting
    attr_accessor :custom_setting

    # @type [Array<String>] mailbox_unique_members
    attr_accessor :mailbox_unique_members

    # @type [Array<String>] site_unique_members
    attr_accessor :site_unique_members

    # @type [Comet::Office365CustomSettingV2] custom_setting_v2
    attr_accessor :custom_setting_v2

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @feature_flag = ''
      @credential = Comet::Office365Credential.new
      @custom_setting = Comet::Office365CustomSetting.new
      @mailbox_unique_members = []
      @site_unique_members = []
      @custom_setting_v2 = Comet::Office365CustomSettingV2.new
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
        when 'FeatureFlag'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @feature_flag = v
        when 'Credential'
          @credential = Comet::Office365Credential.new
          @credential.from_hash(v)
        when 'CustomSetting'
          @custom_setting = Comet::Office365CustomSetting.new
          @custom_setting.from_hash(v)
        when 'MailboxUniqueMembers'
          if v.nil?
            @mailbox_unique_members = []
          else
            @mailbox_unique_members = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @mailbox_unique_members[i1] = v1
            end
          end
        when 'SiteUniqueMembers'
          if v.nil?
            @site_unique_members = []
          else
            @site_unique_members = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @site_unique_members[i1] = v1
            end
          end
        when 'CustomSettingV2'
          @custom_setting_v2 = Comet::Office365CustomSettingV2.new
          @custom_setting_v2.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['FeatureFlag'] = @feature_flag
      ret['Credential'] = @credential
      ret['CustomSetting'] = @custom_setting
      ret['MailboxUniqueMembers'] = @mailbox_unique_members
      ret['SiteUniqueMembers'] = @site_unique_members
      ret['CustomSettingV2'] = @custom_setting_v2
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
