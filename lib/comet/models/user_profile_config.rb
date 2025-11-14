# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # UserProfileConfig is a typed class wrapper around the underlying Comet Server API data structure.
  # This is the main data structure for a user's profile.
  class UserProfileConfig

    # The name for this account. It uniquely identifies this UserProfileConfig across the entire Comet
    # Server. It cannot be changed directly.
    # @type [String] username
    attr_accessor :username

    # A longer descriptive name for this account. It is not necessarily unique to the Comet Server. The
    # end-user might be able to change it inside the Comet Backup desktop app.
    # @type [String] account_name
    attr_accessor :account_name

    # Timezone in IANA format. Individual devices may declare a more specific timezone in the Devices
    # field.
    # @type [String] local_timezone
    attr_accessor :local_timezone

    # One of the supported languages, such as en_US (DEFAULT_LANGUAGE).
    # @type [String] language_code
    attr_accessor :language_code

    # Tenant
    # @type [String] organization_id
    attr_accessor :organization_id

    # @type [String] group_id
    attr_accessor :group_id

    # A list of email addresses to send reports to.
    # @type [Array<String>] emails
    attr_accessor :emails

    # By default, all the email addresses in the Emails field will receive the policy-default or
    # server-wide-default style of email report. Add an override for a specific email address in here to
    # allow customizing the email report that will be received.
    # @type [Hash{String => Comet::UserCustomEmailSettings}] override_email_settings
    attr_accessor :override_email_settings

    # This option can be used to control whether any email reports are sent.
    # @type [Boolean] send_email_reports
    attr_accessor :send_email_reports

    # Storage Vaults
    # The string keys can be any unique key. Using a GUID is recommended, but optional.
    # @type [Hash{String => Comet::DestinationConfig}] destinations
    attr_accessor :destinations

    # Leave as true
    # @type [Boolean] supports_device_associations
    attr_accessor :supports_device_associations

    # Protected Items
    # The string keys can be any unique key. Using a GUID is recommended, but optional.
    # @type [Hash{String => Comet::SourceConfig}] sources
    attr_accessor :sources

    # Schedules
    # The string keys can be any unique key. Using a GUID is recommended, but optional.
    # @type [Hash{String => Comet::BackupRuleConfig}] backup_rules
    attr_accessor :backup_rules

    # Devices
    # The string keys are the device's ID. The device ID is generated automatically based on a mix of
    # hardware and software identifiers on the installed PC.
    # To revoke a device, use the AdminRevokeDevice API instead of accessing these fields directly. This
    # API can also remove associated Protected Items, uninstall the remote device, and disconnect its
    # live connection.
    # @type [Hash{String => Comet::DeviceConfig}] devices
    attr_accessor :devices

    # @type [Boolean] is_suspended
    attr_accessor :is_suspended

    # Unix timestamp in seconds. Zero if the device is not suspended.
    # @type [Number] last_suspended
    attr_accessor :last_suspended

    # A limit on the total Size of all Protected Items in this account. The number of bytes should be
    # configured in AllProtectedItemsQuotaBytes.
    # @type [Boolean] all_protected_items_quota_enabled
    attr_accessor :all_protected_items_quota_enabled

    # A limit on the total Size of all Protected Items in this account. It is enforced if
    # AllProtectedItemsQuotaEnabled is true.
    # @type [Number] all_protected_items_quota_bytes
    attr_accessor :all_protected_items_quota_bytes

    # A limit on the total number of devices registered in this account. Set to zero to allow unlimited
    # devices.
    # @type [Number] maximum_devices
    attr_accessor :maximum_devices

    # A limit on the total number of Office 365 Protected Accounts across all Office 365 Protected Items
    # in this account. Set to zero to allow unlimited Office 365 Protected Accounts.
    # @type [Number] quota_office_365protected_accounts
    attr_accessor :quota_office_365protected_accounts

    # A limit on the total number of Hyper-V guests across all Hyper-V Protected Items in this account.
    # Set to zero to allow unlimited Office 365 Protected Accounts.
    # @type [Number] quota_hyper_vguests
    attr_accessor :quota_hyper_vguests

    # A limit on the total number of VMware guests across all VMware Protected Items in this account.
    # Set to zero to allow unlimited Office 365 Protected Accounts.
    # @type [Number] quota_vmware_guests
    attr_accessor :quota_vmware_guests

    # If the PolicyID field is set to a non-empty string, the Comet Server will enforce the contents of
    # the Policy field based on the matching server's policy. Otherwise if the PolicyID field is set to
    # an empty string, the administrator may configure any custom values in the Policy field.
    # @type [String] policy_id
    attr_accessor :policy_id

    # The Policy field contains a read-only copy of the effective Policy that is applied to this user
    # account.
    # @type [Comet::UserPolicy] policy
    attr_accessor :policy

    # One of the PASSWORD_FORMAT_ constants
    # To change the user's password, use the AdminResetUserPassword API instead of accessing these
    # fields directly. Otherwise, other encrypted fields in the user profile may become corrupted.
    # @type [Number] password_format
    attr_accessor :password_format

    # @type [String] password_hash
    attr_accessor :password_hash

    # If this field is empty, the "Allow administrator to reset my password" feature is turned off. If
    # this field is filled, it contains a cryptographic root of trust that can decrypt and re-encrypt
    # other secrets in this profile.
    # @type [String] password_recovery
    attr_accessor :password_recovery

    # Allow login using the password alone. Set this to false if the password alone should not be
    # sufficient.
    # @type [Boolean] allow_password_login
    attr_accessor :allow_password_login

    # If true, then TOTP is required to open the desktop app or the Comet Server web interface with this
    # user's credentials.
    # @type [Boolean] allow_password_and_totplogin
    attr_accessor :allow_password_and_totplogin

    # One of the ENCRYPTIONMETHOD_ constants
    # @type [Number] totpkey_encryption_format
    attr_accessor :totpkey_encryption_format

    # @type [String] totpkey
    attr_accessor :totpkey

    # This field is available in Comet 20.3.4 and later.
    # @type [Boolean] require_password_change
    attr_accessor :require_password_change

    # Unix timestamp in seconds
    # @type [Number] create_time
    attr_accessor :create_time

    # A random GUID that is allocated when the user profile is created for the first time. You can use
    # this to help disambiguate users with the same username across multiple Comet Servers.
    # @type [String] creation_guid
    attr_accessor :creation_guid

    # Additional server-wide settings that are enforced for this user profile
    # @type [Comet::UserServerConfig] server_config
    attr_accessor :server_config

    # @type [String] auto_storage_template_guid
    attr_accessor :auto_storage_template_guid

    # If enabled, Linux devices in this user account will sandbox all read/write operations to paths
    # inside user home directories
    # @type [Boolean] linux_homedir_sandbox
    attr_accessor :linux_homedir_sandbox

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @username = ''
      @account_name = ''
      @local_timezone = ''
      @language_code = ''
      @organization_id = ''
      @group_id = ''
      @emails = []
      @override_email_settings = {}
      @destinations = {}
      @sources = {}
      @backup_rules = {}
      @devices = {}
      @last_suspended = 0
      @all_protected_items_quota_bytes = 0
      @maximum_devices = 0
      @quota_office_365protected_accounts = 0
      @quota_hyper_vguests = 0
      @quota_vmware_guests = 0
      @policy_id = ''
      @policy = Comet::UserPolicy.new
      @password_format = 0
      @password_hash = ''
      @password_recovery = ''
      @totpkey_encryption_format = 0
      @totpkey = ''
      @create_time = 0
      @creation_guid = ''
      @server_config = Comet::UserServerConfig.new
      @auto_storage_template_guid = ''
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
        when 'Username'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @username = v
        when 'AccountName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @account_name = v
        when 'LocalTimezone'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @local_timezone = v
        when 'LanguageCode'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @language_code = v
        when 'OrganizationID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @organization_id = v
        when 'GroupID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @group_id = v
        when 'Emails'
          if v.nil?
            @emails = []
          else
            @emails = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @emails[i1] = v1
            end
          end
        when 'OverrideEmailSettings'
          @override_email_settings = {}
          if v.nil?
            @override_email_settings = {}
          else
            v.each do |k1, v1|
              @override_email_settings[k1] = Comet::UserCustomEmailSettings.new
              @override_email_settings[k1].from_hash(v1)
            end
          end
        when 'SendEmailReports'
          @send_email_reports = v
        when 'Destinations'
          @destinations = {}
          if v.nil?
            @destinations = {}
          else
            v.each do |k1, v1|
              @destinations[k1] = Comet::DestinationConfig.new
              @destinations[k1].from_hash(v1)
            end
          end
        when 'SupportsDeviceAssociations'
          @supports_device_associations = v
        when 'Sources'
          @sources = {}
          if v.nil?
            @sources = {}
          else
            v.each do |k1, v1|
              @sources[k1] = Comet::SourceConfig.new
              @sources[k1].from_hash(v1)
            end
          end
        when 'BackupRules'
          @backup_rules = {}
          if v.nil?
            @backup_rules = {}
          else
            v.each do |k1, v1|
              @backup_rules[k1] = Comet::BackupRuleConfig.new
              @backup_rules[k1].from_hash(v1)
            end
          end
        when 'Devices'
          @devices = {}
          if v.nil?
            @devices = {}
          else
            v.each do |k1, v1|
              @devices[k1] = Comet::DeviceConfig.new
              @devices[k1].from_hash(v1)
            end
          end
        when 'IsSuspended'
          @is_suspended = v
        when 'LastSuspended'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @last_suspended = v
        when 'AllProtectedItemsQuotaEnabled'
          @all_protected_items_quota_enabled = v
        when 'AllProtectedItemsQuotaBytes'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @all_protected_items_quota_bytes = v
        when 'MaximumDevices'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @maximum_devices = v
        when 'QuotaOffice365ProtectedAccounts'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @quota_office_365protected_accounts = v
        when 'QuotaHyperVGuests'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @quota_hyper_vguests = v
        when 'QuotaVMwareGuests'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @quota_vmware_guests = v
        when 'PolicyID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @policy_id = v
        when 'Policy'
          @policy = Comet::UserPolicy.new
          @policy.from_hash(v)
        when 'PasswordFormat'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @password_format = v
        when 'PasswordHash'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @password_hash = v
        when 'PasswordRecovery'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @password_recovery = v
        when 'AllowPasswordLogin'
          @allow_password_login = v
        when 'AllowPasswordAndTOTPLogin'
          @allow_password_and_totplogin = v
        when 'TOTPKeyEncryptionFormat'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @totpkey_encryption_format = v
        when 'TOTPKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @totpkey = v
        when 'RequirePasswordChange'
          @require_password_change = v
        when 'CreateTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @create_time = v
        when 'CreationGUID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @creation_guid = v
        when 'ServerConfig'
          @server_config = Comet::UserServerConfig.new
          @server_config.from_hash(v)
        when 'AutoStorageTemplateGUID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @auto_storage_template_guid = v
        when 'LinuxHomedirSandbox'
          @linux_homedir_sandbox = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Username'] = @username
      ret['AccountName'] = @account_name
      ret['LocalTimezone'] = @local_timezone
      ret['LanguageCode'] = @language_code
      unless @organization_id.nil?
        ret['OrganizationID'] = @organization_id
      end
      ret['GroupID'] = @group_id
      ret['Emails'] = @emails
      ret['OverrideEmailSettings'] = @override_email_settings
      ret['SendEmailReports'] = @send_email_reports
      ret['Destinations'] = @destinations
      ret['SupportsDeviceAssociations'] = @supports_device_associations
      ret['Sources'] = @sources
      ret['BackupRules'] = @backup_rules
      ret['Devices'] = @devices
      ret['IsSuspended'] = @is_suspended
      unless @last_suspended.nil?
        ret['LastSuspended'] = @last_suspended
      end
      ret['AllProtectedItemsQuotaEnabled'] = @all_protected_items_quota_enabled
      ret['AllProtectedItemsQuotaBytes'] = @all_protected_items_quota_bytes
      ret['MaximumDevices'] = @maximum_devices
      ret['QuotaOffice365ProtectedAccounts'] = @quota_office_365protected_accounts
      ret['QuotaHyperVGuests'] = @quota_hyper_vguests
      ret['QuotaVMwareGuests'] = @quota_vmware_guests
      ret['PolicyID'] = @policy_id
      ret['Policy'] = @policy
      ret['PasswordFormat'] = @password_format
      ret['PasswordHash'] = @password_hash
      unless @password_recovery.nil?
        ret['PasswordRecovery'] = @password_recovery
      end
      ret['AllowPasswordLogin'] = @allow_password_login
      ret['AllowPasswordAndTOTPLogin'] = @allow_password_and_totplogin
      ret['TOTPKeyEncryptionFormat'] = @totpkey_encryption_format
      ret['TOTPKey'] = @totpkey
      ret['RequirePasswordChange'] = @require_password_change
      ret['CreateTime'] = @create_time
      ret['CreationGUID'] = @creation_guid
      unless @server_config.nil?
        ret['ServerConfig'] = @server_config
      end
      ret['AutoStorageTemplateGUID'] = @auto_storage_template_guid
      ret['LinuxHomedirSandbox'] = @linux_homedir_sandbox
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
