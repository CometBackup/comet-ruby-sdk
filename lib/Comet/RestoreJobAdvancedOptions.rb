# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class RestoreJobAdvancedOptions
    
    # @type [Number] type
    attr_accessor :type
    
    # @type [Boolean] overwrite_existing_files
    attr_accessor :overwrite_existing_files
    
    # @type [String] dest_path
    attr_accessor :dest_path
    
    # @type [Array<String>] exact_dest_paths
    attr_accessor :exact_dest_paths
    
    # @type [Number] archive_format
    attr_accessor :archive_format
    
    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields
    
    def initialize()
      @exact_dest_paths = []
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
        when "Type"
          @type = v
        when "OverwriteExistingFiles"
          @overwrite_existing_files = v
        when "DestPath"
          raise TypeError 'expected string' unless v.is_a? String
          @dest_path = v
        when "ExactDestPaths"
          @exact_dest_paths = Array.new(v.length)
          v.each_with_index do |v, i|
            raise TypeError 'expected string' unless v.is_a? String
            @exact_dest_paths[i] = v
          end
        when "ArchiveFormat"
          @archive_format = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["Type"] = @type
      ret["OverwriteExistingFiles"] = @overwrite_existing_files
      ret["DestPath"] = @dest_path
      ret["ExactDestPaths"] = @exact_dest_paths
      ret["ArchiveFormat"] = @archive_format
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