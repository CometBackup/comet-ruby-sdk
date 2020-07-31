require 'json'

module Comet
  
  class LocalDestinationLocation
    
    # @type [String] localcopy_path
    attr_accessor :localcopy_path
    
    # @type [String] localcopy_win_smbusername
    attr_accessor :localcopy_win_smbusername
    
    # @type [String] localcopy_win_smbpassword
    attr_accessor :localcopy_win_smbpassword
    
    # @type [Number] localcopy_win_smbpassword_format
    attr_accessor :localcopy_win_smbpassword_format
    
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
        when "LocalcopyPath"
          raise TypeError 'expected string' unless v.is_a? String
          @localcopy_path = v
        when "LocalcopyWinSMBUsername"
          raise TypeError 'expected string' unless v.is_a? String
          @localcopy_win_smbusername = v
        when "LocalcopyWinSMBPassword"
          raise TypeError 'expected string' unless v.is_a? String
          @localcopy_win_smbpassword = v
        when "LocalcopyWinSMBPasswordFormat"
          @localcopy_win_smbpassword_format = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["LocalcopyPath"] = @localcopy_path
      ret["LocalcopyWinSMBUsername"] = @localcopy_win_smbusername
      ret["LocalcopyWinSMBPassword"] = @localcopy_win_smbpassword
      ret["LocalcopyWinSMBPasswordFormat"] = @localcopy_win_smbpassword_format
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