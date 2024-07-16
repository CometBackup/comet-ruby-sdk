# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # ServerMetaVersionInfo is a typed class wrapper around the underlying Comet Server API data structure.
  class ServerMetaVersionInfo

    # @type [String] version
    attr_accessor :version

    # @type [String] version_codename
    attr_accessor :version_codename

    # @type [Boolean] storage_role
    attr_accessor :storage_role

    # @type [Boolean] authentication_role
    attr_accessor :authentication_role

    # @type [Boolean] software_build_role
    attr_accessor :software_build_role

    # @type [Boolean] constellation_role__legacy
    # @deprecated This member has been deprecated since Comet version 18.2.0 "Overseer Role" was the old name for the Constellation Role. This field is a duplicate of ConstellationRole for backward compatibility with earlier API consumers.
    attr_accessor :constellation_role__legacy

    # @type [Boolean] constellation_role
    attr_accessor :constellation_role

    # @type [Array<String>] experimental_options
    attr_accessor :experimental_options

    # Unix timestamp, in seconds.
    # @type [Number] server_start_time
    attr_accessor :server_start_time

    # A GUID that was randomly generated when this Comet Server started up. You can check this value to
    # see if the Comet Server has restarted.
    # @type [String] server_start_hash
    attr_accessor :server_start_hash

    # The current time on the Comet Server host machine. Unix timestamp, in seconds. You can check this
    # value to see if clock drift is occuring.
    # @type [Number] current_time
    attr_accessor :current_time

    # A hash derived from the Comet Server's serial number. You can check this value to see if two Comet
    # Server endpoints point to an identical server.
    # @type [String] server_license_hash
    attr_accessor :server_license_hash

    # @type [Boolean] server_license_features_all
    attr_accessor :server_license_features_all

    # @type [Number] server_license_feature_set
    attr_accessor :server_license_feature_set

    # If non-zero, the maximum numbers of devices and Protected Item types that this server is allowed.
    # This field is available in Comet 24.6.3 and later.
    # @type [Comet::LicenseLimits] server_license_limit
    attr_accessor :server_license_limit

    # A count of the devices registered on the server that have a configured Protected Item.
    # This field is available in Comet 24.6.3 and later.
    # @type [Number] configured_devices
    attr_accessor :configured_devices

    # The current number of Protected Item types configured on the server.
    # This field is available in Comet 24.6.3 and later.
    # @type [Hash{String => Number}] booster_limit
    attr_accessor :booster_limit

    # Unix timestamp, in seconds.
    # @type [Number] license_valid_until
    attr_accessor :license_valid_until

    # @type [Number] emails_sent_successfully
    attr_accessor :emails_sent_successfully

    # @type [Number] emails_sent_errors
    attr_accessor :emails_sent_errors

    # @type [Number] emails_waiting_in_queue
    attr_accessor :emails_waiting_in_queue

    # @type [Number] scheduled_email_thread_current_state
    attr_accessor :scheduled_email_thread_current_state

    # @type [Number] scheduled_email_thread_last_calculate_duration_nanos
    attr_accessor :scheduled_email_thread_last_calculate_duration_nanos

    # @type [Number] scheduled_email_thread_waiting_until
    attr_accessor :scheduled_email_thread_waiting_until

    # @type [Number] scheduled_email_thread_last_wake_time
    attr_accessor :scheduled_email_thread_last_wake_time

    # @type [Boolean] scheduled_email_thread_last_wake_sent_emails
    attr_accessor :scheduled_email_thread_last_wake_sent_emails

    # This field is available in Comet 21.3.2 and later.
    # @type [Array<Comet::SelfBackupStatistics>] self_backup
    attr_accessor :self_backup

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @version = ''
      @version_codename = ''
      @experimental_options = []
      @server_start_time = 0
      @server_start_hash = ''
      @current_time = 0
      @server_license_hash = ''
      @server_license_feature_set = 0
      @server_license_limit = Comet::LicenseLimits.new
      @configured_devices = 0
      @booster_limit = {}
      @license_valid_until = 0
      @emails_sent_successfully = 0
      @emails_sent_errors = 0
      @emails_waiting_in_queue = 0
      @scheduled_email_thread_current_state = 0
      @scheduled_email_thread_last_calculate_duration_nanos = 0
      @scheduled_email_thread_waiting_until = 0
      @scheduled_email_thread_last_wake_time = 0
      @self_backup = []
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
        when 'Version'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @version = v
        when 'VersionCodename'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @version_codename = v
        when 'StorageRole'
          @storage_role = v
        when 'AuthenticationRole'
          @authentication_role = v
        when 'SoftwareBuildRole'
          @software_build_role = v
        when 'OverseerRole'
          @constellation_role__legacy = v
        when 'ConstellationRole'
          @constellation_role = v
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
        when 'ServerStartTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @server_start_time = v
        when 'ServerStartHash'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @server_start_hash = v
        when 'CurrentTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @current_time = v
        when 'ServerLicenseHash'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @server_license_hash = v
        when 'ServerLicenseFeaturesAll'
          @server_license_features_all = v
        when 'ServerLicenseFeatureSet'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @server_license_feature_set = v
        when 'ServerLicenseLimit'
          @server_license_limit = Comet::LicenseLimits.new
          @server_license_limit.from_hash(v)
        when 'ConfiguredDevices'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @configured_devices = v
        when 'BoosterLimit'
          @booster_limit = {}
          if v.nil?
            @booster_limit = {}
          else
            v.each do |k1, v1|
              raise TypeError, "'v1' expected Numeric, got #{v1.class}" unless v1.is_a? Numeric

              @booster_limit[k1] = v1
            end
          end
        when 'LicenseValidUntil'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @license_valid_until = v
        when 'EmailsSentSuccessfully'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @emails_sent_successfully = v
        when 'EmailsSentErrors'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @emails_sent_errors = v
        when 'EmailsWaitingInQueue'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @emails_waiting_in_queue = v
        when 'ScheduledEmailThreadCurrentState'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @scheduled_email_thread_current_state = v
        when 'ScheduledEmailThreadLastCalculateDurationNanos'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @scheduled_email_thread_last_calculate_duration_nanos = v
        when 'ScheduledEmailThreadWaitingUntil'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @scheduled_email_thread_waiting_until = v
        when 'ScheduledEmailThreadLastWakeTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @scheduled_email_thread_last_wake_time = v
        when 'ScheduledEmailThreadLastWakeSentEmails'
          @scheduled_email_thread_last_wake_sent_emails = v
        when 'SelfBackup'
          if v.nil?
            @self_backup = []
          else
            @self_backup = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @self_backup[i1] = Comet::SelfBackupStatistics.new
              @self_backup[i1].from_hash(v1)
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
      ret['Version'] = @version
      ret['VersionCodename'] = @version_codename
      ret['StorageRole'] = @storage_role
      ret['AuthenticationRole'] = @authentication_role
      ret['SoftwareBuildRole'] = @software_build_role
      ret['OverseerRole'] = @constellation_role__legacy
      ret['ConstellationRole'] = @constellation_role
      unless @experimental_options.nil?
        ret['ExperimentalOptions'] = @experimental_options
      end
      ret['ServerStartTime'] = @server_start_time
      ret['ServerStartHash'] = @server_start_hash
      ret['CurrentTime'] = @current_time
      ret['ServerLicenseHash'] = @server_license_hash
      ret['ServerLicenseFeaturesAll'] = @server_license_features_all
      ret['ServerLicenseFeatureSet'] = @server_license_feature_set
      ret['ServerLicenseLimit'] = @server_license_limit
      ret['ConfiguredDevices'] = @configured_devices
      ret['BoosterLimit'] = @booster_limit
      ret['LicenseValidUntil'] = @license_valid_until
      ret['EmailsSentSuccessfully'] = @emails_sent_successfully
      ret['EmailsSentErrors'] = @emails_sent_errors
      ret['EmailsWaitingInQueue'] = @emails_waiting_in_queue
      ret['ScheduledEmailThreadCurrentState'] = @scheduled_email_thread_current_state
      ret['ScheduledEmailThreadLastCalculateDurationNanos'] = @scheduled_email_thread_last_calculate_duration_nanos
      ret['ScheduledEmailThreadWaitingUntil'] = @scheduled_email_thread_waiting_until
      ret['ScheduledEmailThreadLastWakeTime'] = @scheduled_email_thread_last_wake_time
      ret['ScheduledEmailThreadLastWakeSentEmails'] = @scheduled_email_thread_last_wake_sent_emails
      ret['SelfBackup'] = @self_backup
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
