# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class UserProfileConfig
    
    # @type [String] username
    attr_accessor :username
    
    # @type [String] account_name
    attr_accessor :account_name
    
    # @type [String] local_timezone
    attr_accessor :local_timezone
    
    # @type [String] language_code
    attr_accessor :language_code
    
    # @type [Array<String>] emails
    attr_accessor :emails
    
    # @type [Hash{String => Comet::UserCustomEmailSettings}] override_email_settings
    attr_accessor :override_email_settings
    
    # @type [Boolean] send_email_reports
    attr_accessor :send_email_reports
    
    # @type [Hash{String => Comet::DestinationConfig}] destinations
    attr_accessor :destinations
    
    # @type [Hash{String => Comet::SourceConfig}] sources
    attr_accessor :sources
    
    # @type [Hash{String => Comet::BackupRuleConfig}] backup_rules
    attr_accessor :backup_rules
    
    # @type [Hash{String => Comet::DeviceConfig}] devices
    attr_accessor :devices
    
    # @type [Boolean] is_suspended
    attr_accessor :is_suspended
    
    # @type [Boolean] all_protected_items_quota_enabled
    attr_accessor :all_protected_items_quota_enabled
    
    # @type [Number] all_protected_items_quota_bytes
    attr_accessor :all_protected_items_quota_bytes
    
    # @type [Number] maximum_devices
    attr_accessor :maximum_devices
    
    # @type [String] policy_id
    attr_accessor :policy_id
    
    # @type [Comet::UserPolicy] policy
    attr_accessor :policy
    
    # @type [Number] password_format
    attr_accessor :password_format
    
    # @type [String] password_hash
    attr_accessor :password_hash
    
    # @type [String] password_recovery
    attr_accessor :password_recovery
    
    # @type [Boolean] allow_password_login
    attr_accessor :allow_password_login
    
    # @type [Boolean] allow_password_and_totplogin
    attr_accessor :allow_password_and_totplogin
    
    # @type [Number] totpkey_encryption_format
    attr_accessor :totpkey_encryption_format
    
    # @type [String] totpkey
    attr_accessor :totpkey
    
    # @type [Boolean] require_password_change
    attr_accessor :require_password_change
    
    # @type [Number] create_time
    attr_accessor :create_time
    
    # @type [String] creation_guid
    attr_accessor :creation_guid
    
    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields
    
    def initialize()
      @emails = []
      @override_email_settings = {}
      @destinations = {}
      @sources = {}
      @backup_rules = {}
      @devices = {}
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
        when "Username"
          raise TypeError 'expected string' unless v.is_a? String
          @username = v
        when "AccountName"
          raise TypeError 'expected string' unless v.is_a? String
          @account_name = v
        when "LocalTimezone"
          raise TypeError 'expected string' unless v.is_a? String
          @local_timezone = v
        when "LanguageCode"
          raise TypeError 'expected string' unless v.is_a? String
          @language_code = v
        when "Emails"
          @emails = Array.new(v.length)
          v.each_with_index do |v, i|
            raise TypeError 'expected string' unless v.is_a? String
            @emails[i] = v
          end
        when "OverrideEmailSettings"
          @override_email_settings = {}
          v.each do |k, v|
            @override_email_settings[k] = Comet::UserCustomEmailSettings.new
            @override_email_settings[k].from_hash(v)
          end
        when "SendEmailReports"
          @send_email_reports = v
        when "Destinations"
          @destinations = {}
          v.each do |k, v|
            @destinations[k] = Comet::DestinationConfig.new
            @destinations[k].from_hash(v)
          end
        when "Sources"
          @sources = {}
          v.each do |k, v|
            @sources[k] = Comet::SourceConfig.new
            @sources[k].from_hash(v)
          end
        when "BackupRules"
          @backup_rules = {}
          v.each do |k, v|
            @backup_rules[k] = Comet::BackupRuleConfig.new
            @backup_rules[k].from_hash(v)
          end
        when "Devices"
          @devices = {}
          v.each do |k, v|
            @devices[k] = Comet::DeviceConfig.new
            @devices[k].from_hash(v)
          end
        when "IsSuspended"
          @is_suspended = v
        when "AllProtectedItemsQuotaEnabled"
          @all_protected_items_quota_enabled = v
        when "AllProtectedItemsQuotaBytes"
          @all_protected_items_quota_bytes = v
        when "MaximumDevices"
          @maximum_devices = v
        when "PolicyID"
          raise TypeError 'expected string' unless v.is_a? String
          @policy_id = v
        when "Policy"
          @policy = Comet::UserPolicy.new
          @policy.from_hash(v)
        when "PasswordFormat"
          @password_format = v
        when "PasswordHash"
          raise TypeError 'expected string' unless v.is_a? String
          @password_hash = v
        when "PasswordRecovery"
          raise TypeError 'expected string' unless v.is_a? String
          @password_recovery = v
        when "AllowPasswordLogin"
          @allow_password_login = v
        when "AllowPasswordAndTOTPLogin"
          @allow_password_and_totplogin = v
        when "TOTPKeyEncryptionFormat"
          @totpkey_encryption_format = v
        when "TOTPKey"
          raise TypeError 'expected string' unless v.is_a? String
          @totpkey = v
        when "RequirePasswordChange"
          @require_password_change = v
        when "CreateTime"
          @create_time = v
        when "CreationGUID"
          raise TypeError 'expected string' unless v.is_a? String
          @creation_guid = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["Username"] = @username
      ret["AccountName"] = @account_name
      ret["LocalTimezone"] = @local_timezone
      ret["LanguageCode"] = @language_code
      ret["Emails"] = @emails
      ret["OverrideEmailSettings"] = @override_email_settings
      ret["SendEmailReports"] = @send_email_reports
      ret["Destinations"] = @destinations
      ret["Sources"] = @sources
      ret["BackupRules"] = @backup_rules
      ret["Devices"] = @devices
      ret["IsSuspended"] = @is_suspended
      ret["AllProtectedItemsQuotaEnabled"] = @all_protected_items_quota_enabled
      ret["AllProtectedItemsQuotaBytes"] = @all_protected_items_quota_bytes
      ret["MaximumDevices"] = @maximum_devices
      ret["PolicyID"] = @policy_id
      ret["Policy"] = @policy
      ret["PasswordFormat"] = @password_format
      ret["PasswordHash"] = @password_hash
      if @password_recovery != nil
        ret["PasswordRecovery"] = @password_recovery
      end
      ret["AllowPasswordLogin"] = @allow_password_login
      ret["AllowPasswordAndTOTPLogin"] = @allow_password_and_totplogin
      ret["TOTPKeyEncryptionFormat"] = @totpkey_encryption_format
      ret["TOTPKey"] = @totpkey
      ret["RequirePasswordChange"] = @require_password_change
      ret["CreateTime"] = @create_time
      ret["CreationGUID"] = @creation_guid
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