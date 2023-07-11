# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # ExternalLDAPAuthenticationSourceServer is a typed class wrapper around the underlying Comet Server API data structure.
  class ExternalLDAPAuthenticationSourceServer

    # @type [String] hostname
    attr_accessor :hostname

    # @type [Number] port
    attr_accessor :port

    # One of the LDAPSECURITYMETHOD_ constants (e.g. "plain" / "ldaps" / "starttls")
    # @type [String] security_method
    attr_accessor :security_method

    # @type [Boolean] accept_invalid_ssl
    attr_accessor :accept_invalid_ssl

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @hostname = ''
      @port = 0
      @security_method = ''
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
        when 'Hostname'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @hostname = v
        when 'Port'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @port = v
        when 'SecurityMethod'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @security_method = v
        when 'AcceptInvalidSSL'
          @accept_invalid_ssl = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Hostname'] = @hostname
      ret['Port'] = @port
      ret['SecurityMethod'] = @security_method
      ret['AcceptInvalidSSL'] = @accept_invalid_ssl
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
