# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # U2FSignRequest is a typed class wrapper around the underlying Comet Server API data structure.
  # @deprecated This type has been deprecated since Comet version 21.12.0
  class U2FSignRequest

    # @type [String] challenge_id
    attr_accessor :challenge_id

    # @type [String] challenge_data
    attr_accessor :challenge_data

    # @type [String] app_id
    attr_accessor :app_id

    # @type [Array<Comet::U2FRegisteredKey>] registered_keys
    attr_accessor :registered_keys

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @challenge_id = ''
      @challenge_data = ''
      @app_id = ''
      @registered_keys = []
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
        when 'ChallengeID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @challenge_id = v
        when 'ChallengeData'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @challenge_data = v
        when 'AppID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @app_id = v
        when 'RegisteredKeys'
          if v.nil?
            @registered_keys = []
          else
            @registered_keys = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @registered_keys[i1] = Comet::U2FRegisteredKey.new
              @registered_keys[i1].from_hash(v1)
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
      ret['ChallengeID'] = @challenge_id
      ret['ChallengeData'] = @challenge_data
      ret['AppID'] = @app_id
      ret['RegisteredKeys'] = @registered_keys
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
