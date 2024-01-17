# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # BucketUsageInfo is a typed class wrapper around the underlying Comet Server API data structure.
  class BucketUsageInfo

    # @type [String] access_key
    attr_accessor :access_key

    # The servers where this bucket was found. The 0-based indexes here correspond to the entries inside
    # ConstellationRoleOptions->Servers.
    # @type [Array<Number>] exists_on_servers
    attr_accessor :exists_on_servers

    # @type [Array<Comet::UserOnServer>] in_use_by
    attr_accessor :in_use_by

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @access_key = ''
      @exists_on_servers = []
      @in_use_by = []
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
        when 'AccessKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @access_key = v
        when 'ExistsOnServers'
          if v.nil?
            @exists_on_servers = []
          else
            @exists_on_servers = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected Numeric, got #{v1.class}" unless v1.is_a? Numeric

              @exists_on_servers[i1] = v1
            end
          end
        when 'InUseBy'
          if v.nil?
            @in_use_by = []
          else
            @in_use_by = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @in_use_by[i1] = Comet::UserOnServer.new
              @in_use_by[i1].from_hash(v1)
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
      ret['AccessKey'] = @access_key
      ret['ExistsOnServers'] = @exists_on_servers
      ret['InUseBy'] = @in_use_by
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
