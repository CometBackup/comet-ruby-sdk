# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class SearchClause
    
    # @type [String] clause_type
    attr_accessor :clause_type
    
    # @type [String] rule_field
    attr_accessor :rule_field
    
    # @type [String] rule_operator
    attr_accessor :rule_operator
    
    # @type [String] rule_value
    attr_accessor :rule_value
    
    # @type [Array<Comet::SearchClause>] clause_children
    attr_accessor :clause_children
    
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
        when "ClauseType"
          raise TypeError 'expected string' unless v.is_a? String
          @clause_type = v
        when "RuleField"
          raise TypeError 'expected string' unless v.is_a? String
          @rule_field = v
        when "RuleOperator"
          raise TypeError 'expected string' unless v.is_a? String
          @rule_operator = v
        when "RuleValue"
          raise TypeError 'expected string' unless v.is_a? String
          @rule_value = v
        when "ClauseChildren"
          @clause_children = Array.new(v.length)
          v.each_with_index do |v, i|
            @clause_children[i] = Comet::SearchClause.new
            @clause_children[i].from_hash(v)
          end
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["ClauseType"] = @clause_type
      ret["RuleField"] = @rule_field
      ret["RuleOperator"] = @rule_operator
      ret["RuleValue"] = @rule_value
      if @clause_children != nil
        ret["ClauseChildren"] = @clause_children
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