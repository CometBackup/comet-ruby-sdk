# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class ProtectedItemEngineTypePolicy
    
    # @type [Boolean] should_restrict_engine_type_list
    attr_accessor :should_restrict_engine_type_list
    
    # @type [Array<String>] allowed_engine_type_when_restricted
    attr_accessor :allowed_engine_type_when_restricted
    
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
        when "ShouldRestrictEngineTypeList"
          @should_restrict_engine_type_list = v
        when "AllowedEngineTypeWhenRestricted"
          @allowed_engine_type_when_restricted = Array.new(v.length)
          v.each_with_index do |v, i|
            raise TypeError 'expected string' unless v.is_a? String
            @allowed_engine_type_when_restricted[i] = v
          end
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["ShouldRestrictEngineTypeList"] = @should_restrict_engine_type_list
      ret["AllowedEngineTypeWhenRestricted"] = @allowed_engine_type_when_restricted
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