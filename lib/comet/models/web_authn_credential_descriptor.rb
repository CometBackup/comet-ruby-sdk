# frozen_string_literal: true

# Copyright (c) 2020-2022 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'base64'
require 'json'

module Comet

  # WebAuthnCredentialDescriptor is a typed class wrapper around the underlying Comet Server API data structure.
  class WebAuthnCredentialDescriptor

    # @type [String] type
    attr_accessor :type

    # @type [Array<Object>] credential_id
    attr_accessor :credential_id

    # @type [Array<String>] transport
    attr_accessor :transport

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @type = ''
      @credential_id = []
      @transport = []
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
        when 'type'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @type = v
        when 'id'
          @credential_id = Base64.decode64(v)
        when 'transports'
          if v.nil?
            @transport = []
          else
            @transport = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @transport[i1] = v1
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
      ret['type'] = @type
      ret['id'] = Base64.strict_encode64(@credential_id)
      unless @transport.nil?
        ret['transports'] = @transport
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
