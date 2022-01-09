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

  # WebAuthnAuthenticatorSelection is a typed class wrapper around the underlying Comet Server API data structure.
  class WebAuthnAuthenticatorSelection

    # @type [String] authenticator_attachment
    attr_accessor :authenticator_attachment

    # @type [Boolean] require_resident_key
    attr_accessor :require_resident_key

    # @type [String] user_verification
    attr_accessor :user_verification

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @authenticator_attachment = ''
      @user_verification = ''
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
        when 'authenticatorAttachment'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @authenticator_attachment = v
        when 'requireResidentKey'
          @require_resident_key = v
        when 'userVerification'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @user_verification = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      unless @authenticator_attachment.nil?
        ret['authenticatorAttachment'] = @authenticator_attachment
      end
      unless @require_resident_key.nil?
        ret['requireResidentKey'] = @require_resident_key
      end
      unless @user_verification.nil?
        ret['userVerification'] = @user_verification
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
