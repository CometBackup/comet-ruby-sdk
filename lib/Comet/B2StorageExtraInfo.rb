# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class B2StorageExtraInfo
    
    # @type [Hash{Number => Comet::B2TransactionTotals}] total_transactions_in_time_interval
    attr_accessor :total_transactions_in_time_interval
    
    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields
    
    def initialize()
      @total_transactions_in_time_interval = {}
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
        when "TotalTransactionsInTimeInterval"
          @total_transactions_in_time_interval = {}
          v.each do |k, v|
            @total_transactions_in_time_interval[k] = Comet::B2TransactionTotals.new
            @total_transactions_in_time_interval[k].from_hash(v)
          end
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["TotalTransactionsInTimeInterval"] = @total_transactions_in_time_interval
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