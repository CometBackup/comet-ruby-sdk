# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # MySQLConnection is a typed class wrapper around the underlying Comet Server API data structure.
  class MySQLConnection

    # @type [String] host
    attr_accessor :host

    # @type [String] port
    attr_accessor :port

    # Optional
    # @type [String] username
    attr_accessor :username

    # Optional
    # @type [String] password
    attr_accessor :password

    # @type [Boolean] use_tls
    attr_accessor :use_tls

    # @type [Boolean] tlsskip_verify
    attr_accessor :tlsskip_verify

    # @type [String] tlscustom_server_capath
    attr_accessor :tlscustom_server_capath

    # @type [String] tlscustom_client_crt_path
    attr_accessor :tlscustom_client_crt_path

    # @type [String] tlscustom_client_key_path
    attr_accessor :tlscustom_client_key_path

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @host = ''
      @port = ''
      @username = ''
      @password = ''
      @tlscustom_server_capath = ''
      @tlscustom_client_crt_path = ''
      @tlscustom_client_key_path = ''
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
        when 'Host'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @host = v
        when 'Port'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @port = v
        when 'Username'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @username = v
        when 'Password'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @password = v
        when 'UseTLS'
          @use_tls = v
        when 'TLSSkipVerify'
          @tlsskip_verify = v
        when 'TLSCustomServerCAPath'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @tlscustom_server_capath = v
        when 'TLSCustomClientCrtPath'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @tlscustom_client_crt_path = v
        when 'TLSCustomClientKeyPath'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @tlscustom_client_key_path = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Host'] = @host
      ret['Port'] = @port
      ret['Username'] = @username
      ret['Password'] = @password
      ret['UseTLS'] = @use_tls
      ret['TLSSkipVerify'] = @tlsskip_verify
      ret['TLSCustomServerCAPath'] = @tlscustom_server_capath
      ret['TLSCustomClientCrtPath'] = @tlscustom_client_crt_path
      ret['TLSCustomClientKeyPath'] = @tlscustom_client_key_path
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
