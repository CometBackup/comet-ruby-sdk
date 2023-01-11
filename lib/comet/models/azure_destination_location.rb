# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # AzureDestinationLocation is a typed class wrapper around the underlying Comet Server API data structure.
  class AzureDestinationLocation

    # @type [String] azbaccount_name
    attr_accessor :azbaccount_name

    # @type [String] azbaccount_key
    attr_accessor :azbaccount_key

    # @type [String] azbcontainer
    attr_accessor :azbcontainer

    # @type [String] azbrealm
    attr_accessor :azbrealm

    # @type [String] azbprefix
    attr_accessor :azbprefix

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @azbaccount_name = ''
      @azbaccount_key = ''
      @azbcontainer = ''
      @azbrealm = ''
      @azbprefix = ''
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
        when 'AZBAccountName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @azbaccount_name = v
        when 'AZBAccountKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @azbaccount_key = v
        when 'AZBContainer'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @azbcontainer = v
        when 'AZBRealm'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @azbrealm = v
        when 'AZBPrefix'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @azbprefix = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['AZBAccountName'] = @azbaccount_name
      ret['AZBAccountKey'] = @azbaccount_key
      ret['AZBContainer'] = @azbcontainer
      ret['AZBRealm'] = @azbrealm
      ret['AZBPrefix'] = @azbprefix
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
