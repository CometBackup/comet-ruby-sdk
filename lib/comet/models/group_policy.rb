# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # GroupPolicy is a typed class wrapper around the underlying Comet Server API data structure.
  class GroupPolicy

    # @type [String] description
    attr_accessor :description

    # @type [String] organization_id
    attr_accessor :organization_id

    # @type [Comet::UserPolicy] policy
    attr_accessor :policy

    # DefaultUserPolicy marks that this UserPolicy should be applied to all new users. The Comet Server
    # will ensure that only one policy can be set as default.
    # @type [Boolean] default_user_policy
    attr_accessor :default_user_policy

    # Unix timestamp in seconds. May be zero for Policies created prior to Comet 23.3.3.
    # @type [Number] created_date
    attr_accessor :created_date

    # Unix timestamp in seconds. May be zero for Policies created prior to Comet 23.3.3.
    # @type [Number] modified_date
    attr_accessor :modified_date

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @description = ''
      @organization_id = ''
      @policy = Comet::UserPolicy.new
      @created_date = 0
      @modified_date = 0
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
        when 'Description'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @description = v
        when 'OrganizationID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @organization_id = v
        when 'Policy'
          @policy = Comet::UserPolicy.new
          @policy.from_hash(v)
        when 'DefaultUserPolicy'
          @default_user_policy = v
        when 'CreatedDate'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @created_date = v
        when 'ModifiedDate'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @modified_date = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Description'] = @description
      ret['OrganizationID'] = @organization_id
      ret['Policy'] = @policy
      ret['DefaultUserPolicy'] = @default_user_policy
      ret['CreatedDate'] = @created_date
      ret['ModifiedDate'] = @modified_date
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
