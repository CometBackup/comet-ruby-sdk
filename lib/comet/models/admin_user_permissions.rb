# frozen_string_literal: true

# Copyright (c) 2020-2022 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # AdminUserPermissions is a typed class wrapper around the underlying Comet Server API data structure.
  class AdminUserPermissions

    # @type [Boolean] prevent_edit_server_settings
    attr_accessor :prevent_edit_server_settings

    # @type [Boolean] prevent_server_shutdown
    attr_accessor :prevent_server_shutdown

    # @type [Boolean] prevent_change_password
    attr_accessor :prevent_change_password

    # @type [Boolean] allow_edit_branding
    attr_accessor :allow_edit_branding

    # @type [Boolean] allow_edit_remote_storage
    attr_accessor :allow_edit_remote_storage

    # @type [Boolean] allow_edit_webhooks
    attr_accessor :allow_edit_webhooks

    # @type [Boolean] deny_constellation_role
    attr_accessor :deny_constellation_role

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
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
        when 'PreventEditServerSettings'
          @prevent_edit_server_settings = v
        when 'PreventServerShutdown'
          @prevent_server_shutdown = v
        when 'PreventChangePassword'
          @prevent_change_password = v
        when 'AllowEditBranding'
          @allow_edit_branding = v
        when 'AllowEditRemoteStorage'
          @allow_edit_remote_storage = v
        when 'AllowEditWebhooks'
          @allow_edit_webhooks = v
        when 'DenyConstellationRole'
          @deny_constellation_role = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      unless @prevent_edit_server_settings.nil?
        ret['PreventEditServerSettings'] = @prevent_edit_server_settings
      end
      unless @prevent_server_shutdown.nil?
        ret['PreventServerShutdown'] = @prevent_server_shutdown
      end
      unless @prevent_change_password.nil?
        ret['PreventChangePassword'] = @prevent_change_password
      end
      unless @allow_edit_branding.nil?
        ret['AllowEditBranding'] = @allow_edit_branding
      end
      unless @allow_edit_remote_storage.nil?
        ret['AllowEditRemoteStorage'] = @allow_edit_remote_storage
      end
      unless @allow_edit_webhooks.nil?
        ret['AllowEditWebhooks'] = @allow_edit_webhooks
      end
      unless @deny_constellation_role.nil?
        ret['DenyConstellationRole'] = @deny_constellation_role
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
