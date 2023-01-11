# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'base64'
require 'json'

module Comet

  # AdminWebAuthnRegistration is a typed class wrapper around the underlying Comet Server API data structure.
  class AdminWebAuthnRegistration

    # @type [String] description
    attr_accessor :description

    # @type [Number] register_time
    attr_accessor :register_time

    # @type [Number] type
    attr_accessor :type

    # @type [Boolean] is_legacy_u2f
    attr_accessor :is_legacy_u2f

    # @type [Array<Object>] id
    attr_accessor :id

    # @type [Comet::WebAuthnCredential] credential
    attr_accessor :credential

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @description = ''
      @register_time = 0
      @type = 0
      @id = []
      @credential = Comet::WebAuthnCredential.new
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
        when 'Description'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @description = v
        when 'RegisterTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @register_time = v
        when 'Type'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @type = v
        when 'IsLegacyU2F'
          @is_legacy_u2f = v
        when 'ID'
          @id = Base64.decode64(v)
        when 'Credential'
          @credential = Comet::WebAuthnCredential.new
          @credential.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Description'] = @description
      ret['RegisterTime'] = @register_time
      ret['Type'] = @type
      unless @is_legacy_u2f.nil?
        ret['IsLegacyU2F'] = @is_legacy_u2f
      end
      unless @id.nil?
        ret['ID'] = @id
      end
      unless @credential.nil?
        ret['Credential'] = @credential
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
