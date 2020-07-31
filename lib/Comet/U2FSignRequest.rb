# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
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
    
    def initialize()
      @registered_keys = []
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
        when "ChallengeID"
          raise TypeError 'expected string' unless v.is_a? String
          @challenge_id = v
        when "ChallengeData"
          raise TypeError 'expected string' unless v.is_a? String
          @challenge_data = v
        when "AppID"
          raise TypeError 'expected string' unless v.is_a? String
          @app_id = v
        when "RegisteredKeys"
          @registered_keys = Array.new(v.length)
          v.each_with_index do |v, i|
            @registered_keys[i] = Comet::U2FRegisteredKey.new
            @registered_keys[i].from_hash(v)
          end
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["ChallengeID"] = @challenge_id
      ret["ChallengeData"] = @challenge_data
      ret["AppID"] = @app_id
      ret["RegisteredKeys"] = @registered_keys
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