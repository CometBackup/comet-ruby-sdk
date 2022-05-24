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

  # AllowedAdminUser is a typed class wrapper around the underlying Comet Server API data structure.
  class AllowedAdminUser

    # @type [String] username
    attr_accessor :username

    # @type [String] organization_id
    attr_accessor :organization_id

    # @type [String] external_authentication_source
    attr_accessor :external_authentication_source

    # @type [Number] password_format
    attr_accessor :password_format

    # @type [String] password
    attr_accessor :password

    # @type [Boolean] allow_password_login
    attr_accessor :allow_password_login

    # @type [Boolean] allow_password_and_totplogin
    attr_accessor :allow_password_and_totplogin

    # @type [Boolean] allow_password_and_u2flogin
    # @deprecated This member has been deprecated since Comet version 21.12.0
    attr_accessor :allow_password_and_u2flogin

    # @type [Boolean] allow_password_and_web_authn_login
    attr_accessor :allow_password_and_web_authn_login

    # @type [Array<Comet::AdminU2FRegistration>] u2fregistrations
    # @deprecated This member has been deprecated since Comet version 21.12.0
    attr_accessor :u2fregistrations

    # @type [Array<Comet::AdminWebAuthnRegistration>] web_authn_registrations
    attr_accessor :web_authn_registrations

    # @type [Number] totpkey_encryption_format
    attr_accessor :totpkey_encryption_format

    # @type [String] totpkey
    attr_accessor :totpkey

    # @type [String] ipwhitelist
    attr_accessor :ipwhitelist

    # @type [Comet::AdminUserPermissions] permissions
    attr_accessor :permissions

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @username = ''
      @organization_id = ''
      @external_authentication_source = ''
      @password_format = 0
      @password = ''
      @u2fregistrations = []
      @web_authn_registrations = []
      @totpkey_encryption_format = 0
      @totpkey = ''
      @ipwhitelist = ''
      @permissions = Comet::AdminUserPermissions.new
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
        when 'OrganizationID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @organization_id = v
        when 'ExternalAuthenticationSource'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @external_authentication_source = v
        when 'PasswordFormat'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @password_format = v
        when 'Password'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @password = v
        when 'AllowPasswordLogin'
          @allow_password_login = v
        when 'AllowPasswordAndTOTPLogin'
          @allow_password_and_totplogin = v
        when 'AllowPasswordAndU2FLogin'
          @allow_password_and_u2flogin = v
        when 'AllowPasswordAndWebAuthnLogin'
          @allow_password_and_web_authn_login = v
        when 'U2FRegistrations'
          if v.nil?
            @u2fregistrations = []
          else
            @u2fregistrations = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @u2fregistrations[i1] = Comet::AdminU2FRegistration.new
              @u2fregistrations[i1].from_hash(v1)
            end
          end
        when 'WebAuthnRegistrations'
          if v.nil?
            @web_authn_registrations = []
          else
            @web_authn_registrations = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @web_authn_registrations[i1] = Comet::AdminWebAuthnRegistration.new
              @web_authn_registrations[i1].from_hash(v1)
            end
          end
        when 'TOTPKeyEncryptionFormat'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @totpkey_encryption_format = v
        when 'TOTPKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @totpkey = v
        when 'IPWhitelist'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @ipwhitelist = v
        when 'Permissions'
          @permissions = Comet::AdminUserPermissions.new
          @permissions.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Username'] = @username
      ret['OrganizationID'] = @organization_id
      unless @external_authentication_source.nil?
        ret['ExternalAuthenticationSource'] = @external_authentication_source
      end
      ret['PasswordFormat'] = @password_format
      ret['Password'] = @password
      ret['AllowPasswordLogin'] = @allow_password_login
      ret['AllowPasswordAndTOTPLogin'] = @allow_password_and_totplogin
      ret['AllowPasswordAndU2FLogin'] = @allow_password_and_u2flogin
      ret['AllowPasswordAndWebAuthnLogin'] = @allow_password_and_web_authn_login
      unless @u2fregistrations.nil?
        ret['U2FRegistrations'] = @u2fregistrations
      end
      unless @web_authn_registrations.nil?
        ret['WebAuthnRegistrations'] = @web_authn_registrations
      end
      unless @totpkey_encryption_format.nil?
        ret['TOTPKeyEncryptionFormat'] = @totpkey_encryption_format
      end
      unless @totpkey.nil?
        ret['TOTPKey'] = @totpkey
      end
      unless @ipwhitelist.nil?
        ret['IPWhitelist'] = @ipwhitelist
      end
      ret['Permissions'] = @permissions
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
