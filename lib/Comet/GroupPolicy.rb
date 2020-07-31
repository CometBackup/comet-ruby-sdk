# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class GroupPolicy
    
    # @type [String] description
    attr_accessor :description
    
    # @type [Comet::UserPolicy] policy
    attr_accessor :policy
    
    # @type [Boolean] default_user_policy
    attr_accessor :default_user_policy
    
    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields
    
    def initialize()
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
        when "Description"
          raise TypeError 'expected string' unless v.is_a? String
          @description = v
        when "Policy"
          @policy = Comet::UserPolicy.new
          @policy.from_hash(v)
        when "DefaultUserPolicy"
          @default_user_policy = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["Description"] = @description
      ret["Policy"] = @policy
      ret["DefaultUserPolicy"] = @default_user_policy
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