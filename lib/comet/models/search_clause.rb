# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # SearchClause is a typed class wrapper around the underlying Comet Server API data structure.
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

    def initialize
      clear
    end

    def clear
      @clause_type = ''
      @rule_field = ''
      @rule_operator = ''
      @rule_value = ''
      @clause_children = []
      @unknown_json_fields = {}
    end

    # @param [String] json_string The complete object in JSON format
    def from_json(json_string)
      raise TypeError, "'json_string' expected String, got #{json_string.class}" unless json_string.is_a? String

      from_hash(JSON.parse(json_string))
    end

    # @param [Hash] obj The complete object as a Ruby hash
    def from_hash(obj)
      raise TypeError, "'obj' expected Hash, got #{obj.class}" unless obj.is_a? Hash

      obj.each do |k, v|
        case k
        when 'ClauseType'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @clause_type = v
        when 'RuleField'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @rule_field = v
        when 'RuleOperator'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @rule_operator = v
        when 'RuleValue'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @rule_value = v
        when 'ClauseChildren'
          if v.nil?
            @clause_children = []
          else
            @clause_children = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @clause_children[i1] = Comet::SearchClause.new
              @clause_children[i1].from_hash(v1)
            end
          end
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['ClauseType'] = @clause_type
      ret['RuleField'] = @rule_field
      ret['RuleOperator'] = @rule_operator
      ret['RuleValue'] = @rule_value
      unless @clause_children.nil?
        ret['ClauseChildren'] = @clause_children
      end
      @unknown_json_fields.each do |k, v|
        ret[k] = v
      end
      ret
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_h
      to_hash
    end

    # @return [String] The complete object as a JSON string
    def to_json(options = {})
      to_hash.to_json(options)
    end
  end
end
