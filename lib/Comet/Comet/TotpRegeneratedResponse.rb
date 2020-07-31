require 'json'

module Comet
  
  class TotpRegeneratedResponse
    
    # @type [Number] status
    attr_accessor :status
    
    # @type [String] message
    attr_accessor :message
    
    # @type [String] image
    attr_accessor :image
    
    # @type [String] url
    attr_accessor :url
    
    # @type [String] profile_hash
    attr_accessor :profile_hash
    
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
        when "Status"
          @status = v
        when "Message"
          raise TypeError 'expected string' unless v.is_a? String
          @message = v
        when "Image"
          raise TypeError 'expected string' unless v.is_a? String
          @image = v
        when "URL"
          raise TypeError 'expected string' unless v.is_a? String
          @url = v
        when "ProfileHash"
          raise TypeError 'expected string' unless v.is_a? String
          @profile_hash = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["Status"] = @status
      ret["Message"] = @message
      ret["Image"] = @image
      ret["URL"] = @url
      ret["ProfileHash"] = @profile_hash
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