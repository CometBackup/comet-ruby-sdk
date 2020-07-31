# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class StoredObject
    
    # @type [String] name
    attr_accessor :name
    
    # @type [Number] modify_time
    attr_accessor :modify_time
    
    # @type [String] type
    attr_accessor :type
    
    # @type [String] subtree
    attr_accessor :subtree
    
    # @type [Number] size
    attr_accessor :size
    
    # @type [Boolean] recursive_count_known
    attr_accessor :recursive_count_known
    
    # @type [Number] recursive_files
    attr_accessor :recursive_files
    
    # @type [Number] recursive_bytes
    attr_accessor :recursive_bytes
    
    # @type [Number] recursive_folders
    attr_accessor :recursive_folders
    
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
        when "name"
          raise TypeError 'expected string' unless v.is_a? String
          @name = v
        when "mtime"
          @modify_time = v
        when "type"
          raise TypeError 'expected string' unless v.is_a? String
          @type = v
        when "subtree"
          raise TypeError 'expected string' unless v.is_a? String
          @subtree = v
        when "size"
          @size = v
        when "r"
          @recursive_count_known = v
        when "f"
          @recursive_files = v
        when "b"
          @recursive_bytes = v
        when "d"
          @recursive_folders = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["name"] = @name
      ret["mtime"] = @modify_time
      ret["type"] = @type
      ret["subtree"] = @subtree
      ret["size"] = @size
      if @recursive_count_known != nil
        ret["r"] = @recursive_count_known
      end
      if @recursive_files != nil
        ret["f"] = @recursive_files
      end
      if @recursive_bytes != nil
        ret["b"] = @recursive_bytes
      end
      if @recursive_folders != nil
        ret["d"] = @recursive_folders
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