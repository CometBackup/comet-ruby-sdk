# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class SSHConnection
    
    # @type [String] sshserver
    attr_accessor :sshserver
    
    # @type [String] sshusername
    attr_accessor :sshusername
    
    # @type [Number] sshauth_mode
    attr_accessor :sshauth_mode
    
    # @type [String] sshpassword
    attr_accessor :sshpassword
    
    # @type [String] sshprivate_key
    attr_accessor :sshprivate_key
    
    # @type [Boolean] sshcustom_auth__use_known_hosts_file
    attr_accessor :sshcustom_auth__use_known_hosts_file
    
    # @type [String] sshcustom_auth__known_hosts_file
    attr_accessor :sshcustom_auth__known_hosts_file
    
    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields
    
    def initialize()
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
        when "SSHServer"
          raise TypeError 'expected string' unless v.is_a? String
          @sshserver = v
        when "SSHUsername"
          raise TypeError 'expected string' unless v.is_a? String
          @sshusername = v
        when "SSHAuthMode"
          @sshauth_mode = v
        when "SSHPassword"
          raise TypeError 'expected string' unless v.is_a? String
          @sshpassword = v
        when "SSHPrivateKey"
          raise TypeError 'expected string' unless v.is_a? String
          @sshprivate_key = v
        when "SSHCustomAuth_UseKnownHostsFile"
          @sshcustom_auth__use_known_hosts_file = v
        when "SSHCustomAuth_KnownHostsFile"
          raise TypeError 'expected string' unless v.is_a? String
          @sshcustom_auth__known_hosts_file = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["SSHServer"] = @sshserver
      ret["SSHUsername"] = @sshusername
      ret["SSHAuthMode"] = @sshauth_mode
      ret["SSHPassword"] = @sshpassword
      ret["SSHPrivateKey"] = @sshprivate_key
      ret["SSHCustomAuth_UseKnownHostsFile"] = @sshcustom_auth__use_known_hosts_file
      ret["SSHCustomAuth_KnownHostsFile"] = @sshcustom_auth__known_hosts_file
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