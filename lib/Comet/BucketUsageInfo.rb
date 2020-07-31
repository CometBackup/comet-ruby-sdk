# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class BucketUsageInfo
    
    # @type [Array<Number>] exists_on_servers
    attr_accessor :exists_on_servers
    
    # @type [Array<Comet::UserOnServer>] in_use_by
    attr_accessor :in_use_by
    
    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields
    
    def initialize()
      @exists_on_servers = []
      @in_use_by = []
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
        when "ExistsOnServers"
          if v != nil
            @exists_on_servers = Array.new(v.length)
            v.each_with_index do |v, i|
              @exists_on_servers[i] = v
            end
          else
            @exists_on_servers = []
          end
        when "InUseBy"
          if v != nil
            @in_use_by = Array.new(v.length)
            v.each_with_index do |v, i|
              @in_use_by[i] = Comet::UserOnServer.new
              @in_use_by[i].from_hash(v)
            end
          else
            @in_use_by = []
          end
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["ExistsOnServers"] = @exists_on_servers
      ret["InUseBy"] = @in_use_by
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