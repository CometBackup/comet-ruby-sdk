# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class ConstellationStatusAPIResponse
    
    # @type [Boolean] deletion_enabled
    attr_accessor :deletion_enabled
    
    # @type [Array<String>] targets
    attr_accessor :targets
    
    # @type [Array<String>] target_names
    attr_accessor :target_names
    
    # @type [Comet::ConstellationStats] stats
    attr_accessor :stats
    
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
        when "DeletionEnabled"
          @deletion_enabled = v
        when "Targets"
          @targets = Array.new(v.length)
          v.each_with_index do |v, i|
            raise TypeError 'expected string' unless v.is_a? String
            @targets[i] = v
          end
        when "TargetNames"
          @target_names = Array.new(v.length)
          v.each_with_index do |v, i|
            raise TypeError 'expected string' unless v.is_a? String
            @target_names[i] = v
          end
        when "Stats"
          @stats = Comet::ConstellationStats.new
          @stats.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["DeletionEnabled"] = @deletion_enabled
      ret["Targets"] = @targets
      if @target_names != nil
        ret["TargetNames"] = @target_names
      end
      ret["Stats"] = @stats
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