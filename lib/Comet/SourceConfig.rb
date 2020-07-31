# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class SourceConfig
    
    # @type [String] engine
    attr_accessor :engine
    
    # @type [String] description
    attr_accessor :description
    
    # @type [String] owner_device
    attr_accessor :owner_device
    
    # @type [Number] create_time
    attr_accessor :create_time
    
    # @type [Number] modify_time
    attr_accessor :modify_time
    
    # @type [Array<String>] pre_exec
    attr_accessor :pre_exec
    
    # @type [Array<String>] post_exec
    attr_accessor :post_exec
    
    # @type [Hash{String => String}] engine_props
    attr_accessor :engine_props
    
    # @type [Hash{String => Comet::RetentionPolicy}] override_destination_retention
    attr_accessor :override_destination_retention
    
    # @type [Comet::SourceStatistics] statistics
    attr_accessor :statistics
    
    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields
    
    def initialize()
      @pre_exec = []
      @post_exec = []
      @engine_props = {}
      @override_destination_retention = {}
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
        when "Engine"
          raise TypeError 'expected string' unless v.is_a? String
          @engine = v
        when "Description"
          raise TypeError 'expected string' unless v.is_a? String
          @description = v
        when "OwnerDevice"
          raise TypeError 'expected string' unless v.is_a? String
          @owner_device = v
        when "CreateTime"
          @create_time = v
        when "ModifyTime"
          @modify_time = v
        when "PreExec"
          @pre_exec = Array.new(v.length)
          v.each_with_index do |v, i|
            raise TypeError 'expected string' unless v.is_a? String
            @pre_exec[i] = v
          end
        when "PostExec"
          @post_exec = Array.new(v.length)
          v.each_with_index do |v, i|
            raise TypeError 'expected string' unless v.is_a? String
            @post_exec[i] = v
          end
        when "EngineProps"
          @engine_props = {}
          v.each do |k, v|
            raise TypeError 'expected string' unless v.is_a? String
            @engine_props[k] = v
          end
        when "OverrideDestinationRetention"
          @override_destination_retention = {}
          v.each do |k, v|
            @override_destination_retention[k] = Comet::RetentionPolicy.new
            @override_destination_retention[k].from_hash(v)
          end
        when "Statistics"
          @statistics = Comet::SourceStatistics.new
          @statistics.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["Engine"] = @engine
      ret["Description"] = @description
      ret["OwnerDevice"] = @owner_device
      ret["CreateTime"] = @create_time
      ret["ModifyTime"] = @modify_time
      ret["PreExec"] = @pre_exec
      ret["PostExec"] = @post_exec
      ret["EngineProps"] = @engine_props
      if @override_destination_retention != nil
        ret["OverrideDestinationRetention"] = @override_destination_retention
      end
      if @statistics != nil
        ret["Statistics"] = @statistics
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