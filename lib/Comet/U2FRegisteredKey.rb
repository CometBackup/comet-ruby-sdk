require 'json'

module Comet
  
  class U2FRegisteredKey
    
    # @type [String] app_id
    attr_accessor :app_id
    
    # @type [String] key_handle
    attr_accessor :key_handle
    
    # @type [String] version
    attr_accessor :version
    
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
        when "AppID"
          raise TypeError 'expected string' unless v.is_a? String
          @app_id = v
        when "KeyHandle"
          raise TypeError 'expected string' unless v.is_a? String
          @key_handle = v
        when "Version"
          raise TypeError 'expected string' unless v.is_a? String
          @version = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["AppID"] = @app_id
      ret["KeyHandle"] = @key_handle
      ret["Version"] = @version
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