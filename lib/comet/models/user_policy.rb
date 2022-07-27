# frozen_string_literal: true

# Copyright (c) 2020-2022 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # UserPolicy is a typed class wrapper around the underlying Comet Server API data structure.
  class UserPolicy

    # @type [Boolean] prevent_request_storage_vault
    attr_accessor :prevent_request_storage_vault

    # @type [Boolean] prevent_add_custom_storage_vault
    attr_accessor :prevent_add_custom_storage_vault

    # @type [Boolean] prevent_edit_storage_vault
    attr_accessor :prevent_edit_storage_vault

    # @type [Boolean] hide_cloud_storage_branding
    attr_accessor :hide_cloud_storage_branding

    # @type [Boolean] prevent_delete_storage_vault
    attr_accessor :prevent_delete_storage_vault

    # @type [Comet::StorageVaultProviderPolicy] storage_vault_providers
    attr_accessor :storage_vault_providers

    # @type [Boolean] prevent_new_protected_item
    attr_accessor :prevent_new_protected_item

    # @type [Boolean] prevent_edit_protected_item
    attr_accessor :prevent_edit_protected_item

    # @type [Boolean] prevent_delete_protected_item
    attr_accessor :prevent_delete_protected_item

    # @type [Comet::ProtectedItemEngineTypePolicy] protected_item_engine_types
    attr_accessor :protected_item_engine_types

    # @type [Array<Comet::ExtraFileExclusion>] file_and_folder_mandatory_exclusions
    attr_accessor :file_and_folder_mandatory_exclusions

    # @type [Number] mode_schedule_skip_already_running
    attr_accessor :mode_schedule_skip_already_running

    # @type [Number] mode_admin_reset_password
    attr_accessor :mode_admin_reset_password

    # @type [Number] mode_admin_view_filenames
    attr_accessor :mode_admin_view_filenames

    # @type [Number] mode_require_user_reset_password
    attr_accessor :mode_require_user_reset_password

    # @type [Boolean] prevent_delete_single_snapshots
    attr_accessor :prevent_delete_single_snapshots

    # @type [Boolean] prevent_change_account_password
    attr_accessor :prevent_change_account_password

    # @type [Boolean] prevent_change_email_settings
    attr_accessor :prevent_change_email_settings

    # @type [Boolean] prevent_change_account_name
    attr_accessor :prevent_change_account_name

    # @type [Boolean] prevent_open_app_ui
    attr_accessor :prevent_open_app_ui

    # @type [Boolean] require_password_open_app_ui
    attr_accessor :require_password_open_app_ui

    # @type [Boolean] hide_app_import
    attr_accessor :hide_app_import

    # @type [Boolean] hide_app_version
    attr_accessor :hide_app_version

    # @type [Boolean] prevent_open_web_ui
    attr_accessor :prevent_open_web_ui

    # @type [Boolean] prevent_view_device_names
    attr_accessor :prevent_view_device_names

    # @type [Comet::DefaultEmailReportPolicy] default_email_reports
    attr_accessor :default_email_reports

    # @type [Comet::RetentionPolicy] default_storage_vault_retention
    attr_accessor :default_storage_vault_retention

    # @type [Boolean] enforce_storage_vault_retention
    attr_accessor :enforce_storage_vault_retention

    # @type [Boolean] prevent_protected_item_retention
    attr_accessor :prevent_protected_item_retention

    # @type [Hash{String => Comet::SourceConfig}] default_sources
    attr_accessor :default_sources

    # @type [Hash{String => Comet::BackupRuleConfig}] default_sources_backup_rules
    attr_accessor :default_sources_backup_rules

    # @type [Hash{String => Comet::DefaultSourceWithOSRestriction}] default_sources_with_osrestriction
    attr_accessor :default_sources_with_osrestriction

    # @type [Hash{String => Comet::BackupRuleConfig}] default_backup_rules
    attr_accessor :default_backup_rules

    # @type [Number] random_delay_secs
    attr_accessor :random_delay_secs

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @storage_vault_providers = Comet::StorageVaultProviderPolicy.new
      @protected_item_engine_types = Comet::ProtectedItemEngineTypePolicy.new
      @file_and_folder_mandatory_exclusions = []
      @mode_schedule_skip_already_running = 0
      @mode_admin_reset_password = 0
      @mode_admin_view_filenames = 0
      @mode_require_user_reset_password = 0
      @default_email_reports = Comet::DefaultEmailReportPolicy.new
      @default_storage_vault_retention = Comet::RetentionPolicy.new
      @default_sources = {}
      @default_sources_backup_rules = {}
      @default_sources_with_osrestriction = {}
      @default_backup_rules = {}
      @random_delay_secs = 0
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
        when 'PreventRequestStorageVault'
          @prevent_request_storage_vault = v
        when 'PreventAddCustomStorageVault'
          @prevent_add_custom_storage_vault = v
        when 'PreventEditStorageVault'
          @prevent_edit_storage_vault = v
        when 'HideCloudStorageBranding'
          @hide_cloud_storage_branding = v
        when 'PreventDeleteStorageVault'
          @prevent_delete_storage_vault = v
        when 'StorageVaultProviders'
          @storage_vault_providers = Comet::StorageVaultProviderPolicy.new
          @storage_vault_providers.from_hash(v)
        when 'PreventNewProtectedItem'
          @prevent_new_protected_item = v
        when 'PreventEditProtectedItem'
          @prevent_edit_protected_item = v
        when 'PreventDeleteProtectedItem'
          @prevent_delete_protected_item = v
        when 'ProtectedItemEngineTypes'
          @protected_item_engine_types = Comet::ProtectedItemEngineTypePolicy.new
          @protected_item_engine_types.from_hash(v)
        when 'FileAndFolderMandatoryExclusions'
          if v.nil?
            @file_and_folder_mandatory_exclusions = []
          else
            @file_and_folder_mandatory_exclusions = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @file_and_folder_mandatory_exclusions[i1] = Comet::ExtraFileExclusion.new
              @file_and_folder_mandatory_exclusions[i1].from_hash(v1)
            end
          end
        when 'ModeScheduleSkipAlreadyRunning'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @mode_schedule_skip_already_running = v
        when 'ModeAdminResetPassword'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @mode_admin_reset_password = v
        when 'ModeAdminViewFilenames'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @mode_admin_view_filenames = v
        when 'ModeRequireUserResetPassword'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @mode_require_user_reset_password = v
        when 'PreventDeleteSingleSnapshots'
          @prevent_delete_single_snapshots = v
        when 'PreventChangeAccountPassword'
          @prevent_change_account_password = v
        when 'PreventChangeEmailSettings'
          @prevent_change_email_settings = v
        when 'PreventChangeAccountName'
          @prevent_change_account_name = v
        when 'PreventOpenAppUI'
          @prevent_open_app_ui = v
        when 'RequirePasswordOpenAppUI'
          @require_password_open_app_ui = v
        when 'HideAppImport'
          @hide_app_import = v
        when 'HideAppVersion'
          @hide_app_version = v
        when 'PreventOpenWebUI'
          @prevent_open_web_ui = v
        when 'PreventViewDeviceNames'
          @prevent_view_device_names = v
        when 'DefaultEmailReports'
          @default_email_reports = Comet::DefaultEmailReportPolicy.new
          @default_email_reports.from_hash(v)
        when 'DefaultStorageVaultRetention'
          @default_storage_vault_retention = Comet::RetentionPolicy.new
          @default_storage_vault_retention.from_hash(v)
        when 'EnforceStorageVaultRetention'
          @enforce_storage_vault_retention = v
        when 'PreventProtectedItemRetention'
          @prevent_protected_item_retention = v
        when 'DefaultSources'
          @default_sources = {}
          if v.nil?
            @default_sources = {}
          else
            v.each do |k1, v1|
              @default_sources[k1] = Comet::SourceConfig.new
              @default_sources[k1].from_hash(v1)
            end
          end
        when 'DefaultSourcesBackupRules'
          @default_sources_backup_rules = {}
          if v.nil?
            @default_sources_backup_rules = {}
          else
            v.each do |k1, v1|
              @default_sources_backup_rules[k1] = Comet::BackupRuleConfig.new
              @default_sources_backup_rules[k1].from_hash(v1)
            end
          end
        when 'DefaultSourcesWithOSRestriction'
          @default_sources_with_osrestriction = {}
          if v.nil?
            @default_sources_with_osrestriction = {}
          else
            v.each do |k1, v1|
              @default_sources_with_osrestriction[k1] = Comet::DefaultSourceWithOSRestriction.new
              @default_sources_with_osrestriction[k1].from_hash(v1)
            end
          end
        when 'DefaultBackupRules'
          @default_backup_rules = {}
          if v.nil?
            @default_backup_rules = {}
          else
            v.each do |k1, v1|
              @default_backup_rules[k1] = Comet::BackupRuleConfig.new
              @default_backup_rules[k1].from_hash(v1)
            end
          end
        when 'RandomDelaySecs'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @random_delay_secs = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['PreventRequestStorageVault'] = @prevent_request_storage_vault
      ret['PreventAddCustomStorageVault'] = @prevent_add_custom_storage_vault
      ret['PreventEditStorageVault'] = @prevent_edit_storage_vault
      ret['HideCloudStorageBranding'] = @hide_cloud_storage_branding
      ret['PreventDeleteStorageVault'] = @prevent_delete_storage_vault
      ret['StorageVaultProviders'] = @storage_vault_providers
      ret['PreventNewProtectedItem'] = @prevent_new_protected_item
      ret['PreventEditProtectedItem'] = @prevent_edit_protected_item
      ret['PreventDeleteProtectedItem'] = @prevent_delete_protected_item
      ret['ProtectedItemEngineTypes'] = @protected_item_engine_types
      unless @file_and_folder_mandatory_exclusions.nil?
        ret['FileAndFolderMandatoryExclusions'] = @file_and_folder_mandatory_exclusions
      end
      unless @mode_schedule_skip_already_running.nil?
        ret['ModeScheduleSkipAlreadyRunning'] = @mode_schedule_skip_already_running
      end
      unless @mode_admin_reset_password.nil?
        ret['ModeAdminResetPassword'] = @mode_admin_reset_password
      end
      unless @mode_admin_view_filenames.nil?
        ret['ModeAdminViewFilenames'] = @mode_admin_view_filenames
      end
      unless @mode_require_user_reset_password.nil?
        ret['ModeRequireUserResetPassword'] = @mode_require_user_reset_password
      end
      ret['PreventDeleteSingleSnapshots'] = @prevent_delete_single_snapshots
      ret['PreventChangeAccountPassword'] = @prevent_change_account_password
      ret['PreventChangeEmailSettings'] = @prevent_change_email_settings
      ret['PreventChangeAccountName'] = @prevent_change_account_name
      ret['PreventOpenAppUI'] = @prevent_open_app_ui
      ret['RequirePasswordOpenAppUI'] = @require_password_open_app_ui
      ret['HideAppImport'] = @hide_app_import
      ret['HideAppVersion'] = @hide_app_version
      ret['PreventOpenWebUI'] = @prevent_open_web_ui
      ret['PreventViewDeviceNames'] = @prevent_view_device_names
      ret['DefaultEmailReports'] = @default_email_reports
      ret['DefaultStorageVaultRetention'] = @default_storage_vault_retention
      ret['EnforceStorageVaultRetention'] = @enforce_storage_vault_retention
      ret['PreventProtectedItemRetention'] = @prevent_protected_item_retention
      ret['DefaultSources'] = @default_sources
      ret['DefaultSourcesBackupRules'] = @default_sources_backup_rules
      ret['DefaultSourcesWithOSRestriction'] = @default_sources_with_osrestriction
      ret['DefaultBackupRules'] = @default_backup_rules
      unless @random_delay_secs.nil?
        ret['RandomDelaySecs'] = @random_delay_secs
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
