#!/usr/bin/env ruby --enable-frozen-string-literal
#
# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT
#
# frozen_string_literal: true

require 'json'

module Comet

  # EmailOptions is a typed class wrapper around the underlying Comet Server API data structure.
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

    def initialize
      clear
    end

    def clear
      @mode = ''
      @from_email = ''
      @from_name = ''
      @smtphost = ''
      @smtpport = 0
      @smtpusername = ''
      @smtppassword = ''
      @unknown_json_fields = {}
    end

    # @param [String] json_string The complete object in JSON format
    def from_json(json_string)
      raise TypeError "'json_string' expected String, got #{json_string.class}" unless json_string.is_a? String

      from_hash(JSON.parse(json_string))
    end

    # @param [Hash] obj The complete object as a Ruby hash
    def from_hash(obj)
      raise TypeError "'obj' expected Hash, got #{obj.class}" unless obj.is_a? Hash

      obj.each do |k, v|
        case k
        when 'Mode'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @mode = v
        when 'FromEmail'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @from_email = v
        when 'FromName'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @from_name = v
        when 'SMTPHost'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @smtphost = v
        when 'SMTPPort'
          raise TypeError "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @smtpport = v
        when 'SMTPUsername'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @smtpusername = v
        when 'SMTPPassword'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @smtppassword = v
        when 'SMTPAllowInvalidCertificate'
          @smtpallow_invalid_certificate = v
        when 'SMTPAllowUnencrypted'
          @smtpallow_unencrypted = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Mode'] = @mode
      ret['FromEmail'] = @from_email
      ret['FromName'] = @from_name
      unless @smtphost.nil?
        ret['SMTPHost'] = @smtphost
      end
      unless @smtpport.nil?
        ret['SMTPPort'] = @smtpport
      end
      unless @smtpusername.nil?
        ret['SMTPUsername'] = @smtpusername
      end
      unless @smtppassword.nil?
        ret['SMTPPassword'] = @smtppassword
      end
      unless @smtpallow_invalid_certificate.nil?
        ret['SMTPAllowInvalidCertificate'] = @smtpallow_invalid_certificate
      end
      unless @smtpallow_unencrypted.nil?
        ret['SMTPAllowUnencrypted'] = @smtpallow_unencrypted
      end
      @unknown_json_fields.each do |k, v|
        ret[k] = v
      end
      ret
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_h
      to_hash
    end

    # @return [String] The complete object as a JSON string
    def to_json(options = {})
      to_hash.to_json(options)
    end
  end
end
