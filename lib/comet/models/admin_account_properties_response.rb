#!/usr/bin/env ruby --enable-frozen-string-literal
#
# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT
#
# frozen_string_literal: true

require 'json'

module Comet

  # AdminAccountPropertiesResponse is a typed class wrapper around the underlying Comet Server API data structure.
  class AdminAccountPropertiesResponse

    # @type [String] organization_id
    attr_accessor :organization_id

    # @type [Comet::AdminUserPermissions] permissions
    attr_accessor :permissions

    # @type [Comet::AdminSecurityOptions] security
    attr_accessor :security

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @organization_id = ''
      @permissions = Comet::AdminUserPermissions.new
      @security = Comet::AdminSecurityOptions.new
      @unknown_json_fields = {}
    end

    # @param [String] json_string The complete object in JSON format
    def from_json(json_string)
      raise TypeError "'json_string' expected String, got #{json_string.class}" unless json_string.is_a? String

      from_hash(JSON.parse(json_string))
    end

    # @param [Hash] obj The complete object as a Ruby hash
    def from_hash(obj)
      raise TypeError "'obj' expected Hash, got #{obj.class}" unless obj.is_a? Hash

      obj.each do |k, v|
        case k
        when 'OrganizationID'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @organization_id = v
        when 'Permissions'
          @permissions = Comet::AdminUserPermissions.new
          @permissions.from_hash(v)
        when 'Security'
          @security = Comet::AdminSecurityOptions.new
          @security.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['OrganizationID'] = @organization_id
      ret['Permissions'] = @permissions
      ret['Security'] = @security
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
