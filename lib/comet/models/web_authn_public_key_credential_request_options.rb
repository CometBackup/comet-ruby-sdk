#!/usr/bin/env ruby --enable-frozen-string-literal
#
# Copyright (c) 2020-2021 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT
#
# frozen_string_literal: true

require 'base64'
require 'json'

module Comet

  # WebAuthnPublicKeyCredentialRequestOptions is a typed class wrapper around the underlying Comet Server API data structure.
  class WebAuthnPublicKeyCredentialRequestOptions

    # @type [Array<Object>] challenge
    attr_accessor :challenge

    # @type [Number] timeout
    attr_accessor :timeout

    # @type [String] relying_party_id
    attr_accessor :relying_party_id

    # @type [Array<Comet::WebAuthnCredentialDescriptor>] allowed_credentials
    attr_accessor :allowed_credentials

    # @type [String] user_verification
    attr_accessor :user_verification

    # @type [Hash{String => Comet::interface}] extensions
    attr_accessor :extensions

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @challenge = []
      @timeout = 0
      @relying_party_id = ''
      @allowed_credentials = []
      @user_verification = ''
      @extensions = {}
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
        when 'challenge'
          @challenge = Base64.decode64(v)
        when 'timeout'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @timeout = v
        when 'rpId'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @relying_party_id = v
        when 'allowCredentials'
          if v.nil?
            @allowed_credentials = []
          else
            @allowed_credentials = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @allowed_credentials[i1] = Comet::WebAuthnCredentialDescriptor.new
              @allowed_credentials[i1].from_hash(v1)
            end
          end
        when 'userVerification'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @user_verification = v
        when 'extensions'
          @extensions = {}
          if v.nil?
            @extensions = {}
          else
            v.each do |k1, v1|
              @extensions[k1] = Comet::interface.new
              @extensions[k1].from_hash(v1)
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
      ret['challenge'] = Base64.strict_encode64(@challenge)
      unless @timeout.nil?
        ret['timeout'] = @timeout
      end
      unless @relying_party_id.nil?
        ret['rpId'] = @relying_party_id
      end
      unless @allowed_credentials.nil?
        ret['allowCredentials'] = @allowed_credentials
      end
      unless @user_verification.nil?
        ret['userVerification'] = @user_verification
      end
      unless @extensions.nil?
        ret['extensions'] = @extensions
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
