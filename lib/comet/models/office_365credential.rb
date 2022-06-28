# frozen_string_literal: true

# Copyright (c) 2020-2022 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # Office365Credential is a typed class wrapper around the underlying Comet Server API data structure.
  class Office365Credential

    # @type [String] app_id
    attr_accessor :app_id

    # @type [String] tenant_id
    attr_accessor :tenant_id

    # @type [String] secret
    attr_accessor :secret

    # @type [String] app_cert
    attr_accessor :app_cert

    # @type [String] region
    attr_accessor :region

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @app_id = ''
      @tenant_id = ''
      @secret = ''
      @app_cert = ''
      @region = ''
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
        when 'AppID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @app_id = v
        when 'TenantID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @tenant_id = v
        when 'Secret'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @secret = v
        when 'AppCert'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @app_cert = v
        when 'Region'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @region = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['AppID'] = @app_id
      ret['TenantID'] = @tenant_id
      ret['Secret'] = @secret
      ret['AppCert'] = @app_cert
      ret['Region'] = @region
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
