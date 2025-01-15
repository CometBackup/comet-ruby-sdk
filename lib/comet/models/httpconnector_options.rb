# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # HTTPConnectorOptions is a typed class wrapper around the underlying Comet Server API data structure.
  class HTTPConnectorOptions

    # @type [String] listen_address___donotusedirectly
    attr_accessor :listen_address___donotusedirectly

    # @type [String] sslcert_path
    attr_accessor :sslcert_path

    # @type [String] sslintermediate
    attr_accessor :sslintermediate

    # @type [String] sslcert_key
    attr_accessor :sslcert_key

    # @type [String] auto_ssldomains
    attr_accessor :auto_ssldomains

    # @type [String] sslpfx_path
    attr_accessor :sslpfx_path

    # @type [String] sslpfx_password
    attr_accessor :sslpfx_password

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @listen_address___donotusedirectly = ''
      @sslcert_path = ''
      @sslintermediate = ''
      @sslcert_key = ''
      @auto_ssldomains = ''
      @sslpfx_path = ''
      @sslpfx_password = ''
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
        when 'ListenAddress'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @listen_address___donotusedirectly = v
        when 'SSLCertPath'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @sslcert_path = v
        when 'SSLIntermediate'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @sslintermediate = v
        when 'SSLCertKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @sslcert_key = v
        when 'AutoSSLDomains'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @auto_ssldomains = v
        when 'SSLPfxPath'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @sslpfx_path = v
        when 'SSLPfxPassword'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @sslpfx_password = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['ListenAddress'] = @listen_address___donotusedirectly
      unless @sslcert_path.nil?
        ret['SSLCertPath'] = @sslcert_path
      end
      unless @sslintermediate.nil?
        ret['SSLIntermediate'] = @sslintermediate
      end
      unless @sslcert_key.nil?
        ret['SSLCertKey'] = @sslcert_key
      end
      unless @auto_ssldomains.nil?
        ret['AutoSSLDomains'] = @auto_ssldomains
      end
      unless @sslpfx_path.nil?
        ret['SSLPfxPath'] = @sslpfx_path
      end
      unless @sslpfx_password.nil?
        ret['SSLPfxPassword'] = @sslpfx_password
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
