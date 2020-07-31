# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class MacOSCodeSignProperties
    
    # @type [Number] level
    attr_accessor :level
    
    # @type [Comet::SSHConnection] sshserver
    attr_accessor :sshserver
    
    # @type [String] certificate_name
    attr_accessor :certificate_name
    
    # @type [String] app_certificate_name
    attr_accessor :app_certificate_name
    
    # @type [String] apple_id
    attr_accessor :apple_id
    
    # @type [String] apple_idpass
    attr_accessor :apple_idpass
    
    # @type [Number] apple_idpass_format
    attr_accessor :apple_idpass_format
    
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
        when "Level"
          @level = v
        when "SSHServer"
          @sshserver = Comet::SSHConnection.new
          @sshserver.from_hash(v)
        when "CertificateName"
          raise TypeError 'expected string' unless v.is_a? String
          @certificate_name = v
        when "AppCertificateName"
          raise TypeError 'expected string' unless v.is_a? String
          @app_certificate_name = v
        when "AppleID"
          raise TypeError 'expected string' unless v.is_a? String
          @apple_id = v
        when "AppleIDPass"
          raise TypeError 'expected string' unless v.is_a? String
          @apple_idpass = v
        when "AppleIDPassFormat"
          @apple_idpass_format = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["Level"] = @level
      ret["SSHServer"] = @sshserver
      ret["CertificateName"] = @certificate_name
      ret["AppCertificateName"] = @app_certificate_name
      ret["AppleID"] = @apple_id
      ret["AppleIDPass"] = @apple_idpass
      ret["AppleIDPassFormat"] = @apple_idpass_format
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