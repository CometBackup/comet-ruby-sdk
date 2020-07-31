# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class EDBFileInfo
    
    # @type [String] name
    attr_accessor :name
    
    # @type [String] guid
    attr_accessor :guid
    
    # @type [String] server_name
    attr_accessor :server_name
    
    # @type [Boolean] circular_logging_enabled
    attr_accessor :circular_logging_enabled
    
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
        when "Name"
          raise TypeError 'expected string' unless v.is_a? String
          @name = v
        when "Guid"
          raise TypeError 'expected string' unless v.is_a? String
          @guid = v
        when "ServerName"
          raise TypeError 'expected string' unless v.is_a? String
          @server_name = v
        when "CircularLoggingEnabled"
          @circular_logging_enabled = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["Name"] = @name
      ret["Guid"] = @guid
      ret["ServerName"] = @server_name
      ret["CircularLoggingEnabled"] = @circular_logging_enabled
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