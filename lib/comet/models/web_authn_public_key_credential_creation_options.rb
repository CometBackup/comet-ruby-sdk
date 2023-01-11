# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'base64'
require 'json'

module Comet

  # WebAuthnPublicKeyCredentialCreationOptions is a typed class wrapper around the underlying Comet Server API data structure.
  class WebAuthnPublicKeyCredentialCreationOptions

    # @type [Array<Object>] challenge
    attr_accessor :challenge

    # @type [Comet::WebAuthnRelyingPartyEntity] relying_party
    attr_accessor :relying_party

    # @type [Comet::WebAuthnUserEntity] user
    attr_accessor :user

    # @type [Array<Comet::WebAuthnCredentialParameter>] parameters
    attr_accessor :parameters

    # @type [Comet::WebAuthnAuthenticatorSelection] authenticator_selection
    attr_accessor :authenticator_selection

    # @type [Number] timeout
    attr_accessor :timeout

    # @type [Array<Comet::WebAuthnCredentialDescriptor>] credential_exclude_list
    attr_accessor :credential_exclude_list

    # @type [Hash{String => Object}] extensions
    attr_accessor :extensions

    # @type [String] attestation
    attr_accessor :attestation

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @challenge = []
      @relying_party = Comet::WebAuthnRelyingPartyEntity.new
      @user = Comet::WebAuthnUserEntity.new
      @parameters = []
      @authenticator_selection = Comet::WebAuthnAuthenticatorSelection.new
      @timeout = 0
      @credential_exclude_list = []
      @extensions = {}
      @attestation = ''
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
        when 'rp'
          @relying_party = Comet::WebAuthnRelyingPartyEntity.new
          @relying_party.from_hash(v)
        when 'user'
          @user = Comet::WebAuthnUserEntity.new
          @user.from_hash(v)
        when 'pubKeyCredParams'
          if v.nil?
            @parameters = []
          else
            @parameters = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @parameters[i1] = Comet::WebAuthnCredentialParameter.new
              @parameters[i1].from_hash(v1)
            end
          end
        when 'authenticatorSelection'
          @authenticator_selection = Comet::WebAuthnAuthenticatorSelection.new
          @authenticator_selection.from_hash(v)
        when 'timeout'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @timeout = v
        when 'excludeCredentials'
          if v.nil?
            @credential_exclude_list = []
          else
            @credential_exclude_list = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @credential_exclude_list[i1] = Comet::WebAuthnCredentialDescriptor.new
              @credential_exclude_list[i1].from_hash(v1)
            end
          end
        when 'extensions'
          @extensions = {}
          if v.nil?
            @extensions = {}
          else
            v.each do |k1, v1|
              @extensions[k1] = v1
            end
          end
        when 'attestation'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @attestation = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['challenge'] = Base64.strict_encode64(@challenge)
      ret['rp'] = @relying_party
      ret['user'] = @user
      unless @parameters.nil?
        ret['pubKeyCredParams'] = @parameters
      end
      unless @authenticator_selection.nil?
        ret['authenticatorSelection'] = @authenticator_selection
      end
      unless @timeout.nil?
        ret['timeout'] = @timeout
      end
      unless @credential_exclude_list.nil?
        ret['excludeCredentials'] = @credential_exclude_list
      end
      unless @extensions.nil?
        ret['extensions'] = @extensions
      end
      unless @attestation.nil?
        ret['attestation'] = @attestation
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
