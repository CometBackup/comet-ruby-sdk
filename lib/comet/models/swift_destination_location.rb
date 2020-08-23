#!/usr/bin/env ruby --enable-frozen-string-literal
#
# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT
#
# frozen_string_literal: true

require 'json'

module Comet

  # SwiftDestinationLocation is a typed class wrapper around the underlying Comet Server API data structure.
  class SwiftDestinationLocation

    # @type [String] username
    attr_accessor :username

    # @type [String] apikey
    attr_accessor :apikey

    # @type [String] region
    attr_accessor :region

    # @type [String] auth_url
    attr_accessor :auth_url

    # @type [String] domain
    attr_accessor :domain

    # @type [String] tenant
    attr_accessor :tenant

    # @type [String] tenant_domain
    attr_accessor :tenant_domain

    # @type [String] tenant_id
    attr_accessor :tenant_id

    # @type [String] trust_id
    attr_accessor :trust_id

    # @type [String] auth_token
    attr_accessor :auth_token

    # @type [String] prefix
    attr_accessor :prefix

    # @type [String] container
    attr_accessor :container

    # @type [String] default_container_policy
    attr_accessor :default_container_policy

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @username = ''
      @apikey = ''
      @region = ''
      @auth_url = ''
      @domain = ''
      @tenant = ''
      @tenant_domain = ''
      @tenant_id = ''
      @trust_id = ''
      @auth_token = ''
      @prefix = ''
      @container = ''
      @default_container_policy = ''
      @unknown_json_fields = {}
    end

    # @param [String] json_string The complete object in JSON format
    def from_json(json_string)
      raise TypeError "'json_string' expected String, got #{json_string.class}" unless json_string.is_a? String

      from_hash(JSON.parse(json_string))
    end

    # @param [Hash] obj The complete object as a Ruby hash
    def from_hash(obj)
      raise TypeError "'obj' expected Hash, got #{obj.class}" unless obj.is_a? Hash

      obj.each do |k, v|
        case k
        when 'Username'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @username = v
        when 'APIKey'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @apikey = v
        when 'Region'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @region = v
        when 'AuthURL'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @auth_url = v
        when 'Domain'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @domain = v
        when 'Tenant'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @tenant = v
        when 'TenantDomain'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @tenant_domain = v
        when 'TenantID'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @tenant_id = v
        when 'TrustID'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @trust_id = v
        when 'AuthToken'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @auth_token = v
        when 'Prefix'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @prefix = v
        when 'Container'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @container = v
        when 'DefaultContainerPolicy'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @default_container_policy = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      unless @username.nil?
        ret['Username'] = @username
      end
      unless @apikey.nil?
        ret['APIKey'] = @apikey
      end
      unless @region.nil?
        ret['Region'] = @region
      end
      unless @auth_url.nil?
        ret['AuthURL'] = @auth_url
      end
      unless @domain.nil?
        ret['Domain'] = @domain
      end
      unless @tenant.nil?
        ret['Tenant'] = @tenant
      end
      unless @tenant_domain.nil?
        ret['TenantDomain'] = @tenant_domain
      end
      unless @tenant_id.nil?
        ret['TenantID'] = @tenant_id
      end
      unless @trust_id.nil?
        ret['TrustID'] = @trust_id
      end
      unless @auth_token.nil?
        ret['AuthToken'] = @auth_token
      end
      unless @prefix.nil?
        ret['Prefix'] = @prefix
      end
      unless @container.nil?
        ret['Container'] = @container
      end
      unless @default_container_policy.nil?
        ret['DefaultContainerPolicy'] = @default_container_policy
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
