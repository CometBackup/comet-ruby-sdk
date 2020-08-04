#!/usr/bin/env ruby --enable-frozen-string-literal
#
# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT
#
# frozen_string_literal: true

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
    attr_accessor :constellation_role__legacy

    # @type [Boolean] constellation_role
    attr_accessor :constellation_role

    # @type [Array<String>] experimental_options
    attr_accessor :experimental_options

    # @type [Number] server_start_time
    attr_accessor :server_start_time

    # @type [String] server_start_hash
    attr_accessor :server_start_hash

    # @type [Number] current_time
    attr_accessor :current_time

    # @type [String] server_license_hash
    attr_accessor :server_license_hash

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

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      @experimental_options = []
      @unknown_json_fields = {}
    end

    # @param [String] json_string The complete object in JSON format
    def from_json(json_string)
      raise TypeError 'expected string' unless json_string.is_a? String

      from_hash(JSON.parse(json_string))
    end

    # @param [Hash] obj The complete object as a Ruby hash
    def from_hash(obj)
      raise TypeError 'expected hash' unless obj.is_a? Hash

      obj.each do |k, v|
        case k
        when 'Version'
          raise TypeError 'expected string' unless v.is_a? String

          @version = v
        when 'VersionCodename'
          raise TypeError 'expected string' unless v.is_a? String

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
              raise TypeError 'expected string' unless v1.is_a? String

              @experimental_options[i1] = v1
            end
          end
        when 'ServerStartTime'
          @server_start_time = v
        when 'ServerStartHash'
          raise TypeError 'expected string' unless v.is_a? String

          @server_start_hash = v
        when 'CurrentTime'
          @current_time = v
        when 'ServerLicenseHash'
          raise TypeError 'expected string' unless v.is_a? String

          @server_license_hash = v
        when 'LicenseValidUntil'
          @license_valid_until = v
        when 'EmailsSentSuccessfully'
          @emails_sent_successfully = v
        when 'EmailsSentErrors'
          @emails_sent_errors = v
        when 'EmailsWaitingInQueue'
          @emails_waiting_in_queue = v
        when 'ScheduledEmailThreadCurrentState'
          @scheduled_email_thread_current_state = v
        when 'ScheduledEmailThreadLastCalculateDurationNanos'
          @scheduled_email_thread_last_calculate_duration_nanos = v
        when 'ScheduledEmailThreadWaitingUntil'
          @scheduled_email_thread_waiting_until = v
        when 'ScheduledEmailThreadLastWakeTime'
          @scheduled_email_thread_last_wake_time = v
        when 'ScheduledEmailThreadLastWakeSentEmails'
          @scheduled_email_thread_last_wake_sent_emails = v
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
      ret['LicenseValidUntil'] = @license_valid_until
      ret['EmailsSentSuccessfully'] = @emails_sent_successfully
      ret['EmailsSentErrors'] = @emails_sent_errors
      ret['EmailsWaitingInQueue'] = @emails_waiting_in_queue
      ret['ScheduledEmailThreadCurrentState'] = @scheduled_email_thread_current_state
      ret['ScheduledEmailThreadLastCalculateDurationNanos'] = @scheduled_email_thread_last_calculate_duration_nanos
      ret['ScheduledEmailThreadWaitingUntil'] = @scheduled_email_thread_waiting_until
      ret['ScheduledEmailThreadLastWakeTime'] = @scheduled_email_thread_last_wake_time
      ret['ScheduledEmailThreadLastWakeSentEmails'] = @scheduled_email_thread_last_wake_sent_emails
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