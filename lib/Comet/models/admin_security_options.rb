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

  # AdminSecurityOptions is a typed class wrapper around the underlying Comet Server API data structure.
  class AdminSecurityOptions

    # @type [Number] password_format
    attr_accessor :password_format

    # @type [String] password
    attr_accessor :password

    # @type [Boolean] allow_password_login
    attr_accessor :allow_password_login

    # @type [Boolean] allow_password_and_totplogin
    attr_accessor :allow_password_and_totplogin

    # @type [Boolean] allow_password_and_u2flogin
    attr_accessor :allow_password_and_u2flogin

    # @type [Array<Comet::AdminU2FRegistration>] u2fregistrations
    attr_accessor :u2fregistrations

    # @type [Number] totpkey_encryption_format
    attr_accessor :totpkey_encryption_format

    # @type [String] totpkey
    attr_accessor :totpkey

    # @type [String] ipwhitelist
    attr_accessor :ipwhitelist

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      @u2fregistrations = []
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
        when 'PasswordFormat'
          @password_format = v
        when 'Password'
          raise TypeError 'expected string' unless v.is_a? String

          @password = v
        when 'AllowPasswordLogin'
          @allow_password_login = v
        when 'AllowPasswordAndTOTPLogin'
          @allow_password_and_totplogin = v
        when 'AllowPasswordAndU2FLogin'
          @allow_password_and_u2flogin = v
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
        when 'TOTPKeyEncryptionFormat'
          @totpkey_encryption_format = v
        when 'TOTPKey'
          raise TypeError 'expected string' unless v.is_a? String

          @totpkey = v
        when 'IPWhitelist'
          raise TypeError 'expected string' unless v.is_a? String

          @ipwhitelist = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['PasswordFormat'] = @password_format
      ret['Password'] = @password
      ret['AllowPasswordLogin'] = @allow_password_login
      ret['AllowPasswordAndTOTPLogin'] = @allow_password_and_totplogin
      ret['AllowPasswordAndU2FLogin'] = @allow_password_and_u2flogin
      unless @u2fregistrations.nil?
        ret['U2FRegistrations'] = @u2fregistrations
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
