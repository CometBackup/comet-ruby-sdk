# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class OSInfo
    
    # @type [String] version
    attr_accessor :version
    
    # @type [String] distribution
    attr_accessor :distribution
    
    # @type [String] build
    attr_accessor :build
    
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
        when "version"
          raise TypeError 'expected string' unless v.is_a? String
          @version = v
        when "distribution"
          raise TypeError 'expected string' unless v.is_a? String
          @distribution = v
        when "build"
          raise TypeError 'expected string' unless v.is_a? String
          @build = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      if @version != nil
        ret["version"] = @version
      end
      if @distribution != nil
        ret["distribution"] = @distribution
      end
      if @build != nil
        ret["build"] = @build
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