# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class SFTPDestinationLocation
    
    # @type [String] sftpserver
    attr_accessor :sftpserver
    
    # @type [String] sftpusername
    attr_accessor :sftpusername
    
    # @type [String] sftpremote_path
    attr_accessor :sftpremote_path
    
    # @type [Number] sftpauth_mode
    attr_accessor :sftpauth_mode
    
    # @type [String] sftppassword
    attr_accessor :sftppassword
    
    # @type [String] sftpprivate_key
    attr_accessor :sftpprivate_key
    
    # @type [Boolean] sftpcustom_auth__use_known_hosts_file
    attr_accessor :sftpcustom_auth__use_known_hosts_file
    
    # @type [String] sftpcustom_auth__known_hosts_file
    attr_accessor :sftpcustom_auth__known_hosts_file
    
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
        when "SFTPServer"
          raise TypeError 'expected string' unless v.is_a? String
          @sftpserver = v
        when "SFTPUsername"
          raise TypeError 'expected string' unless v.is_a? String
          @sftpusername = v
        when "SFTPRemotePath"
          raise TypeError 'expected string' unless v.is_a? String
          @sftpremote_path = v
        when "SFTPAuthMode"
          @sftpauth_mode = v
        when "SFTPPassword"
          raise TypeError 'expected string' unless v.is_a? String
          @sftppassword = v
        when "SFTPPrivateKey"
          raise TypeError 'expected string' unless v.is_a? String
          @sftpprivate_key = v
        when "SFTPCustomAuth_UseKnownHostsFile"
          @sftpcustom_auth__use_known_hosts_file = v
        when "SFTPCustomAuth_KnownHostsFile"
          raise TypeError 'expected string' unless v.is_a? String
          @sftpcustom_auth__known_hosts_file = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["SFTPServer"] = @sftpserver
      ret["SFTPUsername"] = @sftpusername
      ret["SFTPRemotePath"] = @sftpremote_path
      ret["SFTPAuthMode"] = @sftpauth_mode
      ret["SFTPPassword"] = @sftppassword
      ret["SFTPPrivateKey"] = @sftpprivate_key
      ret["SFTPCustomAuth_UseKnownHostsFile"] = @sftpcustom_auth__use_known_hosts_file
      ret["SFTPCustomAuth_KnownHostsFile"] = @sftpcustom_auth__known_hosts_file
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