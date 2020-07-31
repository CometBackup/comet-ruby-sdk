# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class BucketProperties
    
    # @type [Number] create_time
    attr_accessor :create_time
    
    # @type [Number] read_write_key_format
    attr_accessor :read_write_key_format
    
    # @type [String] read_write_key
    attr_accessor :read_write_key
    
    # @type [Comet::SizeMeasurement] size
    attr_accessor :size
    
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
        when "CreateTime"
          @create_time = v
        when "ReadWriteKeyFormat"
          @read_write_key_format = v
        when "ReadWriteKey"
          raise TypeError 'expected string' unless v.is_a? String
          @read_write_key = v
        when "Size"
          @size = Comet::SizeMeasurement.new
          @size.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["CreateTime"] = @create_time
      ret["ReadWriteKeyFormat"] = @read_write_key_format
      ret["ReadWriteKey"] = @read_write_key
      ret["Size"] = @size
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