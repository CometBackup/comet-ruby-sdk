# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class S3DestinationLocation
    
    # @type [String] s3server
    attr_accessor :s3server
    
    # @type [Boolean] s3uses_tls
    attr_accessor :s3uses_tls
    
    # @type [String] s3access_key
    attr_accessor :s3access_key
    
    # @type [String] s3secret_key
    attr_accessor :s3secret_key
    
    # @type [String] s3bucket_name
    attr_accessor :s3bucket_name
    
    # @type [String] s3subdir
    attr_accessor :s3subdir
    
    # @type [Boolean] s3uses_v2signing
    attr_accessor :s3uses_v2signing
    
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
        when "S3Server"
          raise TypeError 'expected string' unless v.is_a? String
          @s3server = v
        when "S3UsesTLS"
          @s3uses_tls = v
        when "S3AccessKey"
          raise TypeError 'expected string' unless v.is_a? String
          @s3access_key = v
        when "S3SecretKey"
          raise TypeError 'expected string' unless v.is_a? String
          @s3secret_key = v
        when "S3BucketName"
          raise TypeError 'expected string' unless v.is_a? String
          @s3bucket_name = v
        when "S3Subdir"
          raise TypeError 'expected string' unless v.is_a? String
          @s3subdir = v
        when "S3UsesV2Signing"
          @s3uses_v2signing = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["S3Server"] = @s3server
      ret["S3UsesTLS"] = @s3uses_tls
      ret["S3AccessKey"] = @s3access_key
      ret["S3SecretKey"] = @s3secret_key
      ret["S3BucketName"] = @s3bucket_name
      ret["S3Subdir"] = @s3subdir
      ret["S3UsesV2Signing"] = @s3uses_v2signing
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