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

  # WindowsCodeSignProperties is a typed class wrapper around the underlying Comet Server API data structure.
  class WindowsCodeSignProperties

    # @type [String] windows_code_sign_pkcs12file_path
    attr_accessor :windows_code_sign_pkcs12file_path

    # @type [Number] windows_code_sign_pkcs12password_format
    attr_accessor :windows_code_sign_pkcs12password_format

    # @type [String] windows_code_sign_pkcs12password
    attr_accessor :windows_code_sign_pkcs12password

    # @type [String] windows_code_sign_pkcs11engine
    attr_accessor :windows_code_sign_pkcs11engine

    # @type [String] windows_code_sign_pkcs11module
    attr_accessor :windows_code_sign_pkcs11module

    # @type [String] windows_code_sign_pkcs11certfile
    attr_accessor :windows_code_sign_pkcs11certfile

    # @type [String] windows_code_sign_pkcs11key_id
    attr_accessor :windows_code_sign_pkcs11key_id

    # @type [Number] windows_code_sign_pkcs11password_format
    attr_accessor :windows_code_sign_pkcs11password_format

    # @type [String] windows_code_sign_pkcs11password
    attr_accessor :windows_code_sign_pkcs11password

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
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
        when 'WindowsCodeSignPKCS12FilePath'
          raise TypeError 'expected string' unless v.is_a? String

          @windows_code_sign_pkcs12file_path = v
        when 'WindowsCodeSignPKCS12PasswordFormat'
          @windows_code_sign_pkcs12password_format = v
        when 'WindowsCodeSignPKCS12Password'
          raise TypeError 'expected string' unless v.is_a? String

          @windows_code_sign_pkcs12password = v
        when 'WindowsCodeSignPKCS11Engine'
          raise TypeError 'expected string' unless v.is_a? String

          @windows_code_sign_pkcs11engine = v
        when 'WindowsCodeSignPKCS11Module'
          raise TypeError 'expected string' unless v.is_a? String

          @windows_code_sign_pkcs11module = v
        when 'WindowsCodeSignPKCS11Certfile'
          raise TypeError 'expected string' unless v.is_a? String

          @windows_code_sign_pkcs11certfile = v
        when 'WindowsCodeSignPKCS11KeyID'
          raise TypeError 'expected string' unless v.is_a? String

          @windows_code_sign_pkcs11key_id = v
        when 'WindowsCodeSignPKCS11PasswordFormat'
          @windows_code_sign_pkcs11password_format = v
        when 'WindowsCodeSignPKCS11Password'
          raise TypeError 'expected string' unless v.is_a? String

          @windows_code_sign_pkcs11password = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['WindowsCodeSignPKCS12FilePath'] = @windows_code_sign_pkcs12file_path
      ret['WindowsCodeSignPKCS12PasswordFormat'] = @windows_code_sign_pkcs12password_format
      ret['WindowsCodeSignPKCS12Password'] = @windows_code_sign_pkcs12password
      ret['WindowsCodeSignPKCS11Engine'] = @windows_code_sign_pkcs11engine
      ret['WindowsCodeSignPKCS11Module'] = @windows_code_sign_pkcs11module
      ret['WindowsCodeSignPKCS11Certfile'] = @windows_code_sign_pkcs11certfile
      ret['WindowsCodeSignPKCS11KeyID'] = @windows_code_sign_pkcs11key_id
      ret['WindowsCodeSignPKCS11PasswordFormat'] = @windows_code_sign_pkcs11password_format
      ret['WindowsCodeSignPKCS11Password'] = @windows_code_sign_pkcs11password
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
