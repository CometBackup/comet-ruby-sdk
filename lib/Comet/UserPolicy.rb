# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
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
    
    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields
    
    def initialize()
      @file_and_folder_mandatory_exclusions = []
      @unknown_json_fields = {}
    end
    
    # @param [String] json_string The complete object in JSON format
    def from_json(json_string)
      from_hash(JSON.parse(json_string))
    end
    
    # @param [Hash] obj The complete object as a Ruby hash
    def from_hash(obj)
      obj.each do |k, v|
        case k
        when "PreventRequestStorageVault"
          @prevent_request_storage_vault = v
        when "PreventAddCustomStorageVault"
          @prevent_add_custom_storage_vault = v
        when "PreventEditStorageVault"
          @prevent_edit_storage_vault = v
        when "HideCloudStorageBranding"
          @hide_cloud_storage_branding = v
        when "PreventDeleteStorageVault"
          @prevent_delete_storage_vault = v
        when "StorageVaultProviders"
          @storage_vault_providers = Comet::StorageVaultProviderPolicy.new
          @storage_vault_providers.from_hash(v)
        when "PreventNewProtectedItem"
          @prevent_new_protected_item = v
        when "PreventEditProtectedItem"
          @prevent_edit_protected_item = v
        when "PreventDeleteProtectedItem"
          @prevent_delete_protected_item = v
        when "ProtectedItemEngineTypes"
          @protected_item_engine_types = Comet::ProtectedItemEngineTypePolicy.new
          @protected_item_engine_types.from_hash(v)
        when "FileAndFolderMandatoryExclusions"
          @file_and_folder_mandatory_exclusions = Array.new(v.length)
          v.each_with_index do |v, i|
            @file_and_folder_mandatory_exclusions[i] = Comet::ExtraFileExclusion.new
            @file_and_folder_mandatory_exclusions[i].from_hash(v)
          end
        when "ModeScheduleSkipAlreadyRunning"
          @mode_schedule_skip_already_running = v
        when "ModeAdminResetPassword"
          @mode_admin_reset_password = v
        when "ModeAdminViewFilenames"
          @mode_admin_view_filenames = v
        when "ModeRequireUserResetPassword"
          @mode_require_user_reset_password = v
        when "PreventDeleteSingleSnapshots"
          @prevent_delete_single_snapshots = v
        when "PreventChangeAccountPassword"
          @prevent_change_account_password = v
        when "PreventChangeEmailSettings"
          @prevent_change_email_settings = v
        when "PreventChangeAccountName"
          @prevent_change_account_name = v
        when "PreventOpenAppUI"
          @prevent_open_app_ui = v
        when "RequirePasswordOpenAppUI"
          @require_password_open_app_ui = v
        when "HideAppImport"
          @hide_app_import = v
        when "HideAppVersion"
          @hide_app_version = v
        when "PreventOpenWebUI"
          @prevent_open_web_ui = v
        when "PreventViewDeviceNames"
          @prevent_view_device_names = v
        when "DefaultEmailReports"
          @default_email_reports = Comet::DefaultEmailReportPolicy.new
          @default_email_reports.from_hash(v)
        when "DefaultStorageVaultRetention"
          @default_storage_vault_retention = Comet::RetentionPolicy.new
          @default_storage_vault_retention.from_hash(v)
        when "EnforceStorageVaultRetention"
          @enforce_storage_vault_retention = v
        when "PreventProtectedItemRetention"
          @prevent_protected_item_retention = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["PreventRequestStorageVault"] = @prevent_request_storage_vault
      ret["PreventAddCustomStorageVault"] = @prevent_add_custom_storage_vault
      ret["PreventEditStorageVault"] = @prevent_edit_storage_vault
      ret["HideCloudStorageBranding"] = @hide_cloud_storage_branding
      ret["PreventDeleteStorageVault"] = @prevent_delete_storage_vault
      ret["StorageVaultProviders"] = @storage_vault_providers
      ret["PreventNewProtectedItem"] = @prevent_new_protected_item
      ret["PreventEditProtectedItem"] = @prevent_edit_protected_item
      ret["PreventDeleteProtectedItem"] = @prevent_delete_protected_item
      ret["ProtectedItemEngineTypes"] = @protected_item_engine_types
      if @file_and_folder_mandatory_exclusions != nil
        ret["FileAndFolderMandatoryExclusions"] = @file_and_folder_mandatory_exclusions
      end
      if @mode_schedule_skip_already_running != nil
        ret["ModeScheduleSkipAlreadyRunning"] = @mode_schedule_skip_already_running
      end
      if @mode_admin_reset_password != nil
        ret["ModeAdminResetPassword"] = @mode_admin_reset_password
      end
      if @mode_admin_view_filenames != nil
        ret["ModeAdminViewFilenames"] = @mode_admin_view_filenames
      end
      if @mode_require_user_reset_password != nil
        ret["ModeRequireUserResetPassword"] = @mode_require_user_reset_password
      end
      ret["PreventDeleteSingleSnapshots"] = @prevent_delete_single_snapshots
      ret["PreventChangeAccountPassword"] = @prevent_change_account_password
      ret["PreventChangeEmailSettings"] = @prevent_change_email_settings
      ret["PreventChangeAccountName"] = @prevent_change_account_name
      ret["PreventOpenAppUI"] = @prevent_open_app_ui
      ret["RequirePasswordOpenAppUI"] = @require_password_open_app_ui
      ret["HideAppImport"] = @hide_app_import
      ret["HideAppVersion"] = @hide_app_version
      ret["PreventOpenWebUI"] = @prevent_open_web_ui
      ret["PreventViewDeviceNames"] = @prevent_view_device_names
      ret["DefaultEmailReports"] = @default_email_reports
      ret["DefaultStorageVaultRetention"] = @default_storage_vault_retention
      ret["EnforceStorageVaultRetention"] = @enforce_storage_vault_retention
      ret["PreventProtectedItemRetention"] = @prevent_protected_item_retention
      @unknown_json_fields.each do |k, v|
        ret[k] = v
      end
      ret
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_h()
      to_hash()
    end
    
    # @return [String] The complete object as a JSON string
    def to_json(*a)
      to_hash().to_json *a
    end
    
  end
  
end # module