# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class StorageVaultProviderPolicy
    
    # @type [Boolean] should_restrict_provider_list
    attr_accessor :should_restrict_provider_list
    
    # @type [Array<Number>] allowed_providers_when_restricted
    attr_accessor :allowed_providers_when_restricted
    
    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields
    
    def initialize()
      @allowed_providers_when_restricted = []
      @unknown_json_fields = {}
    end
    
    # @param [String] json_string The complete object in JSON format
    def from_json(json_string)
      from_hash(JSON.parse(json_string))
    end
    
    # @param [Hash] obj The complete object as a Ruby hash
    def from_hash(obj)
      obj.each do |k, v|
        case k
        when "ShouldRestrictProviderList"
          @should_restrict_provider_list = v
        when "AllowedProvidersWhenRestricted"
          if v != nil
            @allowed_providers_when_restricted = Array.new(v.length)
            v.each_with_index do |v, i|
              @allowed_providers_when_restricted[i] = v
            end
          else
            @allowed_providers_when_restricted = []
          end
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["ShouldRestrictProviderList"] = @should_restrict_provider_list
      ret["AllowedProvidersWhenRestricted"] = @allowed_providers_when_restricted
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