# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # VSphereConnection is a typed class wrapper around the underlying Comet Server API data structure.
  class VSphereConnection

    # @type [String] hostname
    attr_accessor :hostname

    # @type [Boolean] https
    attr_accessor :https

    # @type [Boolean] allow_invalid_certificate
    attr_accessor :allow_invalid_certificate

    # @type [String] username
    attr_accessor :username

    # @type [String] password
    attr_accessor :password

    # @type [String] thumb_print
    attr_accessor :thumb_print

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @hostname = ''
      @username = ''
      @password = ''
      @thumb_print = ''
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
        when 'Https'
          @https = v
        when 'AllowInvalidCertificate'
          @allow_invalid_certificate = v
        when 'Username'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @username = v
        when 'Password'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @password = v
        when 'ThumbPrint'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @thumb_print = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Hostname'] = @hostname
      ret['Https'] = @https
      ret['AllowInvalidCertificate'] = @allow_invalid_certificate
      ret['Username'] = @username
      ret['Password'] = @password
      ret['ThumbPrint'] = @thumb_print
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
