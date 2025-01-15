# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # Office365CustomSetting is a typed class wrapper around the underlying Comet Server API data structure.
  # Office365CustomSetting is used in the EngineProps for an Office 365 Protected Item (see
# ENGINE_BUILTIN_MSOFFICE).
# If present, it will be automatically converted to the replacement Office365CustomSettingV2 type.
  # @deprecated This type has been deprecated since Comet version 21.9.xx
  class Office365CustomSetting

    # @type [String] mailbox_strategy
    attr_accessor :mailbox_strategy

    # @type [String] site_strategy
    attr_accessor :site_strategy

    # @type [Array<String>] mailbox_user_ids
    attr_accessor :mailbox_user_ids

    # @type [Array<String>] mailbox_group_ids
    attr_accessor :mailbox_group_ids

    # @type [Array<String>] site_ids
    attr_accessor :site_ids

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @mailbox_strategy = ''
      @site_strategy = ''
      @mailbox_user_ids = []
      @mailbox_group_ids = []
      @site_ids = []
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
        when 'MailboxStrategy'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @mailbox_strategy = v
        when 'SiteStrategy'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @site_strategy = v
        when 'MailboxUserIDs'
          if v.nil?
            @mailbox_user_ids = []
          else
            @mailbox_user_ids = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @mailbox_user_ids[i1] = v1
            end
          end
        when 'MailboxGroupIDs'
          if v.nil?
            @mailbox_group_ids = []
          else
            @mailbox_group_ids = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @mailbox_group_ids[i1] = v1
            end
          end
        when 'SiteIDs'
          if v.nil?
            @site_ids = []
          else
            @site_ids = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @site_ids[i1] = v1
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
      ret['MailboxStrategy'] = @mailbox_strategy
      ret['SiteStrategy'] = @site_strategy
      ret['MailboxUserIDs'] = @mailbox_user_ids
      ret['MailboxGroupIDs'] = @mailbox_group_ids
      ret['SiteIDs'] = @site_ids
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
