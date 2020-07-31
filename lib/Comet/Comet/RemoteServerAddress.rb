require 'json'

module Comet
  
  class RemoteServerAddress
    
    # @type [String] type
    attr_accessor :type
    
    # @type [String] description
    attr_accessor :description
    
    # @type [String] remote_address
    attr_accessor :remote_address
    
    # @type [String] username
    attr_accessor :username
    
    # @type [String] password
    attr_accessor :password
    
    # @type [Comet::ExternalLDAPAuthenticationSourceSettings] ldap
    attr_accessor :ldap
    
    # @type [Comet::B2VirtualStorageRoleSettings] b2
    attr_accessor :b2
    
    # @type [Comet::WasabiVirtualStorageRoleSettings] wasabi
    attr_accessor :wasabi
    
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
        when "Type"
          raise TypeError 'expected string' unless v.is_a? String
          @type = v
        when "Description"
          raise TypeError 'expected string' unless v.is_a? String
          @description = v
        when "RemoteAddress"
          raise TypeError 'expected string' unless v.is_a? String
          @remote_address = v
        when "Username"
          raise TypeError 'expected string' unless v.is_a? String
          @username = v
        when "Password"
          raise TypeError 'expected string' unless v.is_a? String
          @password = v
        when "LDAP"
          @ldap = Comet::ExternalLDAPAuthenticationSourceSettings.new
          @ldap.from_hash(v)
        when "B2"
          @b2 = Comet::B2VirtualStorageRoleSettings.new
          @b2.from_hash(v)
        when "Wasabi"
          @wasabi = Comet::WasabiVirtualStorageRoleSettings.new
          @wasabi.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["Type"] = @type
      ret["Description"] = @description
      if @remote_address != nil
        ret["RemoteAddress"] = @remote_address
      end
      if @username != nil
        ret["Username"] = @username
      end
      if @password != nil
        ret["Password"] = @password
      end
      if @ldap != nil
        ret["LDAP"] = @ldap
      end
      if @b2 != nil
        ret["B2"] = @b2
      end
      if @wasabi != nil
        ret["Wasabi"] = @wasabi
      end
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