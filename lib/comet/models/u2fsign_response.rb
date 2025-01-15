# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # U2FSignResponse is a typed class wrapper around the underlying Comet Server API data structure.
  # @deprecated This type has been deprecated since Comet version 21.12.0
  class U2FSignResponse

    # @type [String] challenge_id
    attr_accessor :challenge_id

    # @type [String] key_handle
    attr_accessor :key_handle

    # @type [String] signature
    attr_accessor :signature

    # @type [String] client_data
    attr_accessor :client_data

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @challenge_id = ''
      @key_handle = ''
      @signature = ''
      @client_data = ''
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
        when 'ChallengeID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @challenge_id = v
        when 'KeyHandle'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @key_handle = v
        when 'Signature'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @signature = v
        when 'ClientData'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @client_data = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['ChallengeID'] = @challenge_id
      ret['KeyHandle'] = @key_handle
      ret['Signature'] = @signature
      ret['ClientData'] = @client_data
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
