# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
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
    
    def initialize()
      @unknown_json_fields = {} # empty hashmap
    end
    
    # @param [String] json_string The complete object in JSON format
    def from_json(json_string)
      from_hash(JSON.parse(json_string))
    end
    
    # @param [Hash] obj The complete object as a Ruby hash
    def from_hash(obj)
      obj.each do |k, v|
        case k
        when "Username"
          raise TypeError 'expected string' unless v.is_a? String
          @username = v
        when "APIKey"
          raise TypeError 'expected string' unless v.is_a? String
          @apikey = v
        when "Region"
          raise TypeError 'expected string' unless v.is_a? String
          @region = v
        when "AuthURL"
          raise TypeError 'expected string' unless v.is_a? String
          @auth_url = v
        when "Domain"
          raise TypeError 'expected string' unless v.is_a? String
          @domain = v
        when "Tenant"
          raise TypeError 'expected string' unless v.is_a? String
          @tenant = v
        when "TenantDomain"
          raise TypeError 'expected string' unless v.is_a? String
          @tenant_domain = v
        when "TenantID"
          raise TypeError 'expected string' unless v.is_a? String
          @tenant_id = v
        when "TrustID"
          raise TypeError 'expected string' unless v.is_a? String
          @trust_id = v
        when "AuthToken"
          raise TypeError 'expected string' unless v.is_a? String
          @auth_token = v
        when "Prefix"
          raise TypeError 'expected string' unless v.is_a? String
          @prefix = v
        when "Container"
          raise TypeError 'expected string' unless v.is_a? String
          @container = v
        when "DefaultContainerPolicy"
          raise TypeError 'expected string' unless v.is_a? String
          @default_container_policy = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      if @username != nil
        ret["Username"] = @username
      end
      if @apikey != nil
        ret["APIKey"] = @apikey
      end
      if @region != nil
        ret["Region"] = @region
      end
      if @auth_url != nil
        ret["AuthURL"] = @auth_url
      end
      if @domain != nil
        ret["Domain"] = @domain
      end
      if @tenant != nil
        ret["Tenant"] = @tenant
      end
      if @tenant_domain != nil
        ret["TenantDomain"] = @tenant_domain
      end
      if @tenant_id != nil
        ret["TenantID"] = @tenant_id
      end
      if @trust_id != nil
        ret["TrustID"] = @trust_id
      end
      if @auth_token != nil
        ret["AuthToken"] = @auth_token
      end
      if @prefix != nil
        ret["Prefix"] = @prefix
      end
      if @container != nil
        ret["Container"] = @container
      end
      if @default_container_policy != nil
        ret["DefaultContainerPolicy"] = @default_container_policy
      end
      @unknown_json_fields.each do |k, v|
        ret[k] = v
      end
      ret
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_h()
      to_hash()
    end
    
    # @return [String] The complete object as a JSON string
    def to_json(*a)
      to_hash().to_json *a
    end
    
  end
  
end # module