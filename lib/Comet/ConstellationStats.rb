# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class ConstellationStats
    
    # @type [Number] last_check_start
    attr_accessor :last_check_start
    
    # @type [Number] total_checks_started
    attr_accessor :total_checks_started
    
    # @type [Number] total_buckets_deleted
    attr_accessor :total_buckets_deleted
    
    # @type [Number] checks_currently_active
    attr_accessor :checks_currently_active
    
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
        when "LastCheckStart"
          @last_check_start = v
        when "TotalChecksStarted"
          @total_checks_started = v
        when "TotalBucketsDeleted"
          @total_buckets_deleted = v
        when "ChecksCurrentlyActive"
          @checks_currently_active = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["LastCheckStart"] = @last_check_start
      ret["TotalChecksStarted"] = @total_checks_started
      ret["TotalBucketsDeleted"] = @total_buckets_deleted
      ret["ChecksCurrentlyActive"] = @checks_currently_active
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