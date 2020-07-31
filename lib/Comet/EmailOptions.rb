# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class EmailOptions
    
    # @type [String] mode
    attr_accessor :mode
    
    # @type [String] from_email
    attr_accessor :from_email
    
    # @type [String] from_name
    attr_accessor :from_name
    
    # @type [String] smtphost
    attr_accessor :smtphost
    
    # @type [Number] smtpport
    attr_accessor :smtpport
    
    # @type [String] smtpusername
    attr_accessor :smtpusername
    
    # @type [String] smtppassword
    attr_accessor :smtppassword
    
    # @type [Boolean] smtpallow_invalid_certificate
    attr_accessor :smtpallow_invalid_certificate
    
    # @type [Boolean] smtpallow_unencrypted
    attr_accessor :smtpallow_unencrypted
    
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
        when "Mode"
          raise TypeError 'expected string' unless v.is_a? String
          @mode = v
        when "FromEmail"
          raise TypeError 'expected string' unless v.is_a? String
          @from_email = v
        when "FromName"
          raise TypeError 'expected string' unless v.is_a? String
          @from_name = v
        when "SMTPHost"
          raise TypeError 'expected string' unless v.is_a? String
          @smtphost = v
        when "SMTPPort"
          @smtpport = v
        when "SMTPUsername"
          raise TypeError 'expected string' unless v.is_a? String
          @smtpusername = v
        when "SMTPPassword"
          raise TypeError 'expected string' unless v.is_a? String
          @smtppassword = v
        when "SMTPAllowInvalidCertificate"
          @smtpallow_invalid_certificate = v
        when "SMTPAllowUnencrypted"
          @smtpallow_unencrypted = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["Mode"] = @mode
      ret["FromEmail"] = @from_email
      ret["FromName"] = @from_name
      if @smtphost != nil
        ret["SMTPHost"] = @smtphost
      end
      if @smtpport != nil
        ret["SMTPPort"] = @smtpport
      end
      if @smtpusername != nil
        ret["SMTPUsername"] = @smtpusername
      end
      if @smtppassword != nil
        ret["SMTPPassword"] = @smtppassword
      end
      if @smtpallow_invalid_certificate != nil
        ret["SMTPAllowInvalidCertificate"] = @smtpallow_invalid_certificate
      end
      if @smtpallow_unencrypted != nil
        ret["SMTPAllowUnencrypted"] = @smtpallow_unencrypted
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