# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class ConstellationCheckReport
    
    # @type [Number] check_started
    attr_accessor :check_started
    
    # @type [Number] check_completed
    attr_accessor :check_completed
    
    # @type [Hash{String => Comet::BucketUsageInfo}] usage
    attr_accessor :usage
    
    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields
    
    def initialize()
      @usage = {}
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
        when "CheckStarted"
          @check_started = v
        when "CheckCompleted"
          @check_completed = v
        when "Usage"
          @usage = {}
          v.each do |k, v|
            @usage[k] = Comet::BucketUsageInfo.new
            @usage[k].from_hash(v)
          end
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["CheckStarted"] = @check_started
      ret["CheckCompleted"] = @check_completed
      ret["Usage"] = @usage
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