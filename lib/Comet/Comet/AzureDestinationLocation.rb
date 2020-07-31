require 'json'

module Comet
  
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
        when "AZBAccountName"
          raise TypeError 'expected string' unless v.is_a? String
          @azbaccount_name = v
        when "AZBAccountKey"
          raise TypeError 'expected string' unless v.is_a? String
          @azbaccount_key = v
        when "AZBContainer"
          raise TypeError 'expected string' unless v.is_a? String
          @azbcontainer = v
        when "AZBRealm"
          raise TypeError 'expected string' unless v.is_a? String
          @azbrealm = v
        when "AZBPrefix"
          raise TypeError 'expected string' unless v.is_a? String
          @azbprefix = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["AZBAccountName"] = @azbaccount_name
      ret["AZBAccountKey"] = @azbaccount_key
      ret["AZBContainer"] = @azbcontainer
      ret["AZBRealm"] = @azbrealm
      ret["AZBPrefix"] = @azbprefix
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