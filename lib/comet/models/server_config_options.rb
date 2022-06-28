# frozen_string_literal: true

# Copyright (c) 2020-2022 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # ServerConfigOptions is a typed class wrapper around the underlying Comet Server API data structure.
  class ServerConfigOptions

    # @type [Array<String>] experimental_options
    attr_accessor :experimental_options

    # @type [Hash{String => Comet::WebhookOption}] webhook_options
    attr_accessor :webhook_options

    # @type [Comet::LicenseOptions] license
    attr_accessor :license

    # @type [Comet::BrandingOptions] branding
    attr_accessor :branding

    # @type [Array<Comet::AllowedAdminUser>] admin_users
    attr_accessor :admin_users

    # @type [Hash{String => Comet::Organization}] organizations
    attr_accessor :organizations

    # @type [Hash{String => Comet::ExternalAuthenticationSource}] external_admin_user_sources
    attr_accessor :external_admin_user_sources

    # @type [Array<Comet::HTTPConnectorOptions>] listen_addresses
    attr_accessor :listen_addresses

    # @type [Boolean] trust_xforwarded_for
    attr_accessor :trust_xforwarded_for

    # @type [Comet::RatelimitOptions] iprate_limit
    attr_accessor :iprate_limit

    # @type [Comet::EmailOptions] email
    attr_accessor :email

    # @type [Comet::AuthenticationRoleOptions] authentication_role
    attr_accessor :authentication_role

    # @type [Comet::StorageRoleOptions] storage_role
    attr_accessor :storage_role

    # @type [Comet::SoftwareBuildRoleOptions] software_build_role
    attr_accessor :software_build_role

    # @type [Comet::ConstellationRoleOptions] constellation_role
    attr_accessor :constellation_role

    # @type [Comet::ConstellationRoleOptions] constellation_role__legacy
    attr_accessor :constellation_role__legacy

    # @type [Comet::SelfBackupOptions] self_backup
    attr_accessor :self_backup

    # @type [Comet::SessionOptions] session_settings
    attr_accessor :session_settings

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @experimental_options = []
      @webhook_options = {}
      @license = Comet::LicenseOptions.new
      @branding = Comet::BrandingOptions.new
      @admin_users = []
      @organizations = {}
      @external_admin_user_sources = {}
      @listen_addresses = []
      @iprate_limit = Comet::RatelimitOptions.new
      @email = Comet::EmailOptions.new
      @authentication_role = Comet::AuthenticationRoleOptions.new
      @storage_role = Comet::StorageRoleOptions.new
      @software_build_role = Comet::SoftwareBuildRoleOptions.new
      @constellation_role = Comet::ConstellationRoleOptions.new
      @constellation_role__legacy = Comet::ConstellationRoleOptions.new
      @self_backup = Comet::SelfBackupOptions.new
      @session_settings = Comet::SessionOptions.new
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
        when 'ExperimentalOptions'
          if v.nil?
            @experimental_options = []
          else
            @experimental_options = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @experimental_options[i1] = v1
            end
          end
        when 'WebhookOptions'
          @webhook_options = {}
          if v.nil?
            @webhook_options = {}
          else
            v.each do |k1, v1|
              @webhook_options[k1] = Comet::WebhookOption.new
              @webhook_options[k1].from_hash(v1)
            end
          end
        when 'License'
          @license = Comet::LicenseOptions.new
          @license.from_hash(v)
        when 'Branding'
          @branding = Comet::BrandingOptions.new
          @branding.from_hash(v)
        when 'AdminUsers'
          if v.nil?
            @admin_users = []
          else
            @admin_users = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @admin_users[i1] = Comet::AllowedAdminUser.new
              @admin_users[i1].from_hash(v1)
            end
          end
        when 'Organizations'
          @organizations = {}
          if v.nil?
            @organizations = {}
          else
            v.each do |k1, v1|
              @organizations[k1] = Comet::Organization.new
              @organizations[k1].from_hash(v1)
            end
          end
        when 'ExternalAdminUserSources'
          @external_admin_user_sources = {}
          if v.nil?
            @external_admin_user_sources = {}
          else
            v.each do |k1, v1|
              @external_admin_user_sources[k1] = Comet::ExternalAuthenticationSource.new
              @external_admin_user_sources[k1].from_hash(v1)
            end
          end
        when 'ListenAddresses'
          if v.nil?
            @listen_addresses = []
          else
            @listen_addresses = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @listen_addresses[i1] = Comet::HTTPConnectorOptions.new
              @listen_addresses[i1].from_hash(v1)
            end
          end
        when 'TrustXForwardedFor'
          @trust_xforwarded_for = v
        when 'IPRateLimit'
          @iprate_limit = Comet::RatelimitOptions.new
          @iprate_limit.from_hash(v)
        when 'Email'
          @email = Comet::EmailOptions.new
          @email.from_hash(v)
        when 'AuthenticationRole'
          @authentication_role = Comet::AuthenticationRoleOptions.new
          @authentication_role.from_hash(v)
        when 'StorageRole'
          @storage_role = Comet::StorageRoleOptions.new
          @storage_role.from_hash(v)
        when 'SoftwareBuildRole'
          @software_build_role = Comet::SoftwareBuildRoleOptions.new
          @software_build_role.from_hash(v)
        when 'ConstellationRole'
          @constellation_role = Comet::ConstellationRoleOptions.new
          @constellation_role.from_hash(v)
        when 'OverseerRole'
          @constellation_role__legacy = Comet::ConstellationRoleOptions.new
          @constellation_role__legacy.from_hash(v)
        when 'SelfBackup'
          @self_backup = Comet::SelfBackupOptions.new
          @self_backup.from_hash(v)
        when 'SessionSettings'
          @session_settings = Comet::SessionOptions.new
          @session_settings.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      unless @experimental_options.nil?
        ret['ExperimentalOptions'] = @experimental_options
      end
      ret['WebhookOptions'] = @webhook_options
      ret['License'] = @license
      ret['Branding'] = @branding
      ret['AdminUsers'] = @admin_users
      ret['Organizations'] = @organizations
      ret['ExternalAdminUserSources'] = @external_admin_user_sources
      ret['ListenAddresses'] = @listen_addresses
      ret['TrustXForwardedFor'] = @trust_xforwarded_for
      ret['IPRateLimit'] = @iprate_limit
      ret['Email'] = @email
      ret['AuthenticationRole'] = @authentication_role
      ret['StorageRole'] = @storage_role
      ret['SoftwareBuildRole'] = @software_build_role
      ret['ConstellationRole'] = @constellation_role
      unless @constellation_role__legacy.nil?
        ret['OverseerRole'] = @constellation_role__legacy
      end
      ret['SelfBackup'] = @self_backup
      ret['SessionSettings'] = @session_settings
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
