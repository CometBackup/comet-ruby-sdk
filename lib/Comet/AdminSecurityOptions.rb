# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class AdminSecurityOptions
    
    # @type [Number] password_format
    attr_accessor :password_format
    
    # @type [String] password
    attr_accessor :password
    
    # @type [Boolean] allow_password_login
    attr_accessor :allow_password_login
    
    # @type [Boolean] allow_password_and_totplogin
    attr_accessor :allow_password_and_totplogin
    
    # @type [Boolean] allow_password_and_u2flogin
    attr_accessor :allow_password_and_u2flogin
    
    # @type [Array<Comet::AdminU2FRegistration>] u2fregistrations
    attr_accessor :u2fregistrations
    
    # @type [Number] totpkey_encryption_format
    attr_accessor :totpkey_encryption_format
    
    # @type [String] totpkey
    attr_accessor :totpkey
    
    # @type [String] ipwhitelist
    attr_accessor :ipwhitelist
    
    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields
    
    def initialize()
      @u2fregistrations = []
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
        when "PasswordFormat"
          @password_format = v
        when "Password"
          raise TypeError 'expected string' unless v.is_a? String
          @password = v
        when "AllowPasswordLogin"
          @allow_password_login = v
        when "AllowPasswordAndTOTPLogin"
          @allow_password_and_totplogin = v
        when "AllowPasswordAndU2FLogin"
          @allow_password_and_u2flogin = v
        when "U2FRegistrations"
          if v != nil
            @u2fregistrations = Array.new(v.length)
            v.each_with_index do |v, i|
              @u2fregistrations[i] = Comet::AdminU2FRegistration.new
              @u2fregistrations[i].from_hash(v)
            end
          else
            @u2fregistrations = []
          end
        when "TOTPKeyEncryptionFormat"
          @totpkey_encryption_format = v
        when "TOTPKey"
          raise TypeError 'expected string' unless v.is_a? String
          @totpkey = v
        when "IPWhitelist"
          raise TypeError 'expected string' unless v.is_a? String
          @ipwhitelist = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["PasswordFormat"] = @password_format
      ret["Password"] = @password
      ret["AllowPasswordLogin"] = @allow_password_login
      ret["AllowPasswordAndTOTPLogin"] = @allow_password_and_totplogin
      ret["AllowPasswordAndU2FLogin"] = @allow_password_and_u2flogin
      if @u2fregistrations != nil
        ret["U2FRegistrations"] = @u2fregistrations
      end
      if @totpkey_encryption_format != nil
        ret["TOTPKeyEncryptionFormat"] = @totpkey_encryption_format
      end
      if @totpkey != nil
        ret["TOTPKey"] = @totpkey
      end
      if @ipwhitelist != nil
        ret["IPWhitelist"] = @ipwhitelist
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