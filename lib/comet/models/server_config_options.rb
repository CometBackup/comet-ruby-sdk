# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # ServerConfigOptions is a typed class wrapper around the underlying Comet Server API data structure.
  class ServerConfigOptions

    # @type [Array<Comet::AllowedAdminUser>] admin_users
    attr_accessor :admin_users

    # @type [Comet::AuthenticationRoleOptions] authentication_role
    attr_accessor :authentication_role

    # @type [Comet::BrandingOptions] branding
    attr_accessor :branding

    # @type [Comet::ConstellationRoleOptions] constellation_role
    attr_accessor :constellation_role

    # This field is defined for compatibility with 17.x.x versions of Comet Server. Do not rely on this
    # field. In Comet 23.2.x, if this field is defined, it is imported into the replacement
    # 'ConstellationRole' field under the assumption that you are upgrading this Comet Server from a
    # 17.x.x version. In Comet 23.3.x and later, this field is ignored and will not be respected during
    # the import process.
    # @type [Comet::ConstellationRoleOptions] constellation_role__legacy
    attr_accessor :constellation_role__legacy

    # @type [Comet::EmailOptions] email
    attr_accessor :email

    # An array of GUIDs that can enable additional early-access functionality
    # @type [Array<String>] experimental_options
    attr_accessor :experimental_options

    # @type [Hash{String => Comet::ExternalAuthenticationSource}] external_admin_user_sources
    attr_accessor :external_admin_user_sources

    # The Comet Server can enforce a bandwidth limit based on the target IP address
    # @type [Comet::RatelimitOptions] iprate_limit
    attr_accessor :iprate_limit

    # @type [Comet::LicenseOptions] license
    attr_accessor :license

    # Configure ip, port, and SSL settings for this self-hosted Comet Server.
    # @type [Array<Comet::HTTPConnectorOptions>] listen_addresses
    attr_accessor :listen_addresses

    # Tenants
    # @type [Hash{String => Comet::Organization}] organizations
    attr_accessor :organizations

    # @type [Array<Comet::PSAConfig>] psaconfigs
    attr_accessor :psaconfigs

    # Automatically create backup zip files of this Comet Server's configuration
    # @type [Comet::SelfBackupOptions] self_backup
    attr_accessor :self_backup

    # Control how long admin accounts can remain logged in to the Comet Server web interface
    # @type [Comet::SessionOptions] session_settings
    attr_accessor :session_settings

    # @type [Comet::SoftwareBuildRoleOptions] software_build_role
    attr_accessor :software_build_role

    # @type [Comet::StorageRoleOptions] storage_role
    attr_accessor :storage_role

    # If true, the X-Forwarded-For header will be trusted for the purposes of IP allowlisting. This
    # should only be enabled when you explicitly configure Comet Server behind a reverse proxy,
    # otherwise it could allow malicious users to bypass the IP allowlist.
    # @type [Boolean] trust_xforwarded_for
    attr_accessor :trust_xforwarded_for

    # @type [Hash{String => Comet::WebhookOption}] webhook_options
    attr_accessor :webhook_options

    # @type [Hash{String => Comet::FileOption}] audit_file_options
    attr_accessor :audit_file_options

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @admin_users = []
      @authentication_role = Comet::AuthenticationRoleOptions.new
      @branding = Comet::BrandingOptions.new
      @constellation_role = Comet::ConstellationRoleOptions.new
      @constellation_role__legacy = Comet::ConstellationRoleOptions.new
      @email = Comet::EmailOptions.new
      @experimental_options = []
      @external_admin_user_sources = {}
      @iprate_limit = Comet::RatelimitOptions.new
      @license = Comet::LicenseOptions.new
      @listen_addresses = []
      @organizations = {}
      @psaconfigs = []
      @self_backup = Comet::SelfBackupOptions.new
      @session_settings = Comet::SessionOptions.new
      @software_build_role = Comet::SoftwareBuildRoleOptions.new
      @storage_role = Comet::StorageRoleOptions.new
      @webhook_options = {}
      @audit_file_options = {}
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
        when 'AuthenticationRole'
          @authentication_role = Comet::AuthenticationRoleOptions.new
          @authentication_role.from_hash(v)
        when 'Branding'
          @branding = Comet::BrandingOptions.new
          @branding.from_hash(v)
        when 'ConstellationRole'
          @constellation_role = Comet::ConstellationRoleOptions.new
          @constellation_role.from_hash(v)
        when 'OverseerRole'
          @constellation_role__legacy = Comet::ConstellationRoleOptions.new
          @constellation_role__legacy.from_hash(v)
        when 'Email'
          @email = Comet::EmailOptions.new
          @email.from_hash(v)
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
        when 'IPRateLimit'
          @iprate_limit = Comet::RatelimitOptions.new
          @iprate_limit.from_hash(v)
        when 'License'
          @license = Comet::LicenseOptions.new
          @license.from_hash(v)
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
        when 'PSAConfigs'
          if v.nil?
            @psaconfigs = []
          else
            @psaconfigs = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @psaconfigs[i1] = Comet::PSAConfig.new
              @psaconfigs[i1].from_hash(v1)
            end
          end
        when 'SelfBackup'
          @self_backup = Comet::SelfBackupOptions.new
          @self_backup.from_hash(v)
        when 'SessionSettings'
          @session_settings = Comet::SessionOptions.new
          @session_settings.from_hash(v)
        when 'SoftwareBuildRole'
          @software_build_role = Comet::SoftwareBuildRoleOptions.new
          @software_build_role.from_hash(v)
        when 'StorageRole'
          @storage_role = Comet::StorageRoleOptions.new
          @storage_role.from_hash(v)
        when 'TrustXForwardedFor'
          @trust_xforwarded_for = v
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
        when 'AuditFileOptions'
          @audit_file_options = {}
          if v.nil?
            @audit_file_options = {}
          else
            v.each do |k1, v1|
              @audit_file_options[k1] = Comet::FileOption.new
              @audit_file_options[k1].from_hash(v1)
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
      ret['AdminUsers'] = @admin_users
      ret['AuthenticationRole'] = @authentication_role
      ret['Branding'] = @branding
      ret['ConstellationRole'] = @constellation_role
      unless @constellation_role__legacy.nil?
        ret['OverseerRole'] = @constellation_role__legacy
      end
      ret['Email'] = @email
      unless @experimental_options.nil?
        ret['ExperimentalOptions'] = @experimental_options
      end
      ret['ExternalAdminUserSources'] = @external_admin_user_sources
      ret['IPRateLimit'] = @iprate_limit
      ret['License'] = @license
      ret['ListenAddresses'] = @listen_addresses
      ret['Organizations'] = @organizations
      ret['PSAConfigs'] = @psaconfigs
      ret['SelfBackup'] = @self_backup
      ret['SessionSettings'] = @session_settings
      ret['SoftwareBuildRole'] = @software_build_role
      ret['StorageRole'] = @storage_role
      ret['TrustXForwardedFor'] = @trust_xforwarded_for
      ret['WebhookOptions'] = @webhook_options
      ret['AuditFileOptions'] = @audit_file_options
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
