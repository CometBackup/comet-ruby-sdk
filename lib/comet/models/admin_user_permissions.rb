# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
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

    # @type [Boolean] allow_edit_email_options
    attr_accessor :allow_edit_email_options

    # @type [Boolean] allow_edit_remote_storage
    attr_accessor :allow_edit_remote_storage

    # @type [Boolean] allow_edit_webhooks
    attr_accessor :allow_edit_webhooks

    # @type [Boolean] allow_edit_external_auth_sources
    attr_accessor :allow_edit_external_auth_sources

    # @type [Boolean] deny_constellation_role
    attr_accessor :deny_constellation_role

    # This field is available in Comet 23.6.0 and later.
    # @type [Boolean] deny_view_server_history
    attr_accessor :deny_view_server_history

    # This field is available in Comet 23.6.0 and later.
    # @type [Boolean] deny_view_server_info
    attr_accessor :deny_view_server_info

    # This field is available in Comet 23.6.0 and later.
    # @type [Boolean] prevent_request_storage_vault
    attr_accessor :prevent_request_storage_vault

    # This field is available in Comet 23.6.0 and later.
    # @type [Boolean] prevent_add_custom_storage_vault
    attr_accessor :prevent_add_custom_storage_vault

    # This field is available in Comet 23.6.0 and later.
    # @type [Boolean] hide_cloud_storage_branding
    attr_accessor :hide_cloud_storage_branding

    # This field is available in Comet 23.6.0 and later.
    # @type [Boolean] should_restrict_provider_list
    attr_accessor :should_restrict_provider_list

    # This field is available in Comet 23.6.0 and later.
    # @type [Array<Number>] allowed_providers_when_restricted
    attr_accessor :allowed_providers_when_restricted

    # This field is available in Comet 23.9.11 and later.
    # @type [Array<String>] allowed_user_policies
    attr_accessor :allowed_user_policies

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @allowed_providers_when_restricted = []
      @allowed_user_policies = []
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
        when 'AllowEditEmailOptions'
          @allow_edit_email_options = v
        when 'AllowEditRemoteStorage'
          @allow_edit_remote_storage = v
        when 'AllowEditWebhooks'
          @allow_edit_webhooks = v
        when 'AllowEditExternalAuthSources'
          @allow_edit_external_auth_sources = v
        when 'DenyConstellationRole'
          @deny_constellation_role = v
        when 'DenyViewServerHistory'
          @deny_view_server_history = v
        when 'DenyViewServerInfo'
          @deny_view_server_info = v
        when 'PreventRequestStorageVault'
          @prevent_request_storage_vault = v
        when 'PreventAddCustomStorageVault'
          @prevent_add_custom_storage_vault = v
        when 'HideCloudStorageBranding'
          @hide_cloud_storage_branding = v
        when 'ShouldRestrictProviderList'
          @should_restrict_provider_list = v
        when 'AllowedProvidersWhenRestricted'
          if v.nil?
            @allowed_providers_when_restricted = []
          else
            @allowed_providers_when_restricted = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected Numeric, got #{v1.class}" unless v1.is_a? Numeric

              @allowed_providers_when_restricted[i1] = v1
            end
          end
        when 'AllowedUserPolicies'
          if v.nil?
            @allowed_user_policies = []
          else
            @allowed_user_policies = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @allowed_user_policies[i1] = v1
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
      unless @allow_edit_email_options.nil?
        ret['AllowEditEmailOptions'] = @allow_edit_email_options
      end
      unless @allow_edit_remote_storage.nil?
        ret['AllowEditRemoteStorage'] = @allow_edit_remote_storage
      end
      unless @allow_edit_webhooks.nil?
        ret['AllowEditWebhooks'] = @allow_edit_webhooks
      end
      unless @allow_edit_external_auth_sources.nil?
        ret['AllowEditExternalAuthSources'] = @allow_edit_external_auth_sources
      end
      unless @deny_constellation_role.nil?
        ret['DenyConstellationRole'] = @deny_constellation_role
      end
      unless @deny_view_server_history.nil?
        ret['DenyViewServerHistory'] = @deny_view_server_history
      end
      unless @deny_view_server_info.nil?
        ret['DenyViewServerInfo'] = @deny_view_server_info
      end
      unless @prevent_request_storage_vault.nil?
        ret['PreventRequestStorageVault'] = @prevent_request_storage_vault
      end
      unless @prevent_add_custom_storage_vault.nil?
        ret['PreventAddCustomStorageVault'] = @prevent_add_custom_storage_vault
      end
      unless @hide_cloud_storage_branding.nil?
        ret['HideCloudStorageBranding'] = @hide_cloud_storage_branding
      end
      unless @should_restrict_provider_list.nil?
        ret['ShouldRestrictProviderList'] = @should_restrict_provider_list
      end
      unless @allowed_providers_when_restricted.nil?
        ret['AllowedProvidersWhenRestricted'] = @allowed_providers_when_restricted
      end
      unless @allowed_user_policies.nil?
        ret['AllowedUserPolicies'] = @allowed_user_policies
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
