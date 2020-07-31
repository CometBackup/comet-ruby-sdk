# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class DispatcherStoredObjectsResponse
    
    # @type [Number] status
    attr_accessor :status
    
    # @type [String] message
    attr_accessor :message
    
    # @type [Array<Comet::StoredObject>] stored_objects
    attr_accessor :stored_objects
    
    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields
    
    def initialize()
      @stored_objects = []
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
        when "Status"
          @status = v
        when "Message"
          raise TypeError 'expected string' unless v.is_a? String
          @message = v
        when "StoredObjects"
          @stored_objects = Array.new(v.length)
          v.each_with_index do |v, i|
            @stored_objects[i] = Comet::StoredObject.new
            @stored_objects[i].from_hash(v)
          end
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["Status"] = @status
      ret["Message"] = @message
      ret["StoredObjects"] = @stored_objects
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