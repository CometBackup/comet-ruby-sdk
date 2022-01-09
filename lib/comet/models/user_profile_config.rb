#!/usr/bin/env ruby --enable-frozen-string-literal
#
# Copyright (c) 2020-2022 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT
#
# frozen_string_literal: true

require 'json'

module Comet

  # UserProfileConfig is a typed class wrapper around the underlying Comet Server API data structure.
  class UserProfileConfig

    # @type [String] username
    attr_accessor :username

    # @type [String] account_name
    attr_accessor :account_name

    # @type [String] local_timezone
    attr_accessor :local_timezone

    # @type [String] language_code
    attr_accessor :language_code

    # @type [String] organization_id
    attr_accessor :organization_id

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

    def initialize
      clear
    end

    def clear
      @username = ''
      @account_name = ''
      @local_timezone = ''
      @language_code = ''
      @organization_id = ''
      @emails = []
      @override_email_settings = {}
      @destinations = {}
      @sources = {}
      @backup_rules = {}
      @devices = {}
      @all_protected_items_quota_bytes = 0
      @maximum_devices = 0
      @policy_id = ''
      @policy = Comet::UserPolicy.new
      @password_format = 0
      @password_hash = ''
      @password_recovery = ''
      @totpkey_encryption_format = 0
      @totpkey = ''
      @create_time = 0
      @creation_guid = ''
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
        when 'AllProtectedItemsQuotaEnabled'
          @all_protected_items_quota_enabled = v
        when 'AllProtectedItemsQuotaBytes'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @all_protected_items_quota_bytes = v
        when 'MaximumDevices'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @maximum_devices = v
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
      ret['Emails'] = @emails
      ret['OverrideEmailSettings'] = @override_email_settings
      ret['SendEmailReports'] = @send_email_reports
      ret['Destinations'] = @destinations
      ret['Sources'] = @sources
      ret['BackupRules'] = @backup_rules
      ret['Devices'] = @devices
      ret['IsSuspended'] = @is_suspended
      ret['AllProtectedItemsQuotaEnabled'] = @all_protected_items_quota_enabled
      ret['AllProtectedItemsQuotaBytes'] = @all_protected_items_quota_bytes
      ret['MaximumDevices'] = @maximum_devices
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
