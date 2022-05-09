#!/usr/bin/env ruby --enable-frozen-string-literal
#
# Copyright (c) 2020-2022 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT
#
# frozen_string_literal: true

require 'json'

module Comet

  # MacOSCodeSignProperties is a typed class wrapper around the underlying Comet Server API data structure.
  class MacOSCodeSignProperties

    # @type [Number] level
    attr_accessor :level

    # @type [Boolean] sign_locally
    attr_accessor :sign_locally

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

    # @type [String] certificate_file
    attr_accessor :certificate_file

    # @type [String] app_certificate_file
    attr_accessor :app_certificate_file

    # @type [String] pfx_file_password
    attr_accessor :pfx_file_password

    # @type [Number] pfx_file_password_format
    attr_accessor :pfx_file_password_format

    # @type [String] notary_apiissuer_id
    attr_accessor :notary_apiissuer_id

    # @type [String] notary_apikey_id
    attr_accessor :notary_apikey_id

    # @type [String] notary_apikey_file
    attr_accessor :notary_apikey_file

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @level = 0
      @sshserver = Comet::SSHConnection.new
      @certificate_name = ''
      @app_certificate_name = ''
      @apple_id = ''
      @apple_idpass = ''
      @apple_idpass_format = 0
      @certificate_file = ''
      @app_certificate_file = ''
      @pfx_file_password = ''
      @pfx_file_password_format = 0
      @notary_apiissuer_id = ''
      @notary_apikey_id = ''
      @notary_apikey_file = ''
      @unknown_json_fields = {}
    end

    # @param [String] json_string The complete object in JSON format
    def from_json(json_string)
      raise TypeError, "'json_string' expected String, got #{json_string.class}" unless json_string.is_a? String

      from_hash(JSON.parse(json_string))
    end

    # @param [Hash] obj The complete object as a Ruby hash
    def from_hash(obj)
      raise TypeError, "'obj' expected Hash, got #{obj.class}" unless obj.is_a? Hash

      obj.each do |k, v|
        case k
        when 'Level'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @level = v
        when 'SignLocally'
          @sign_locally = v
        when 'SSHServer'
          @sshserver = Comet::SSHConnection.new
          @sshserver.from_hash(v)
        when 'CertificateName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @certificate_name = v
        when 'AppCertificateName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @app_certificate_name = v
        when 'AppleID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @apple_id = v
        when 'AppleIDPass'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @apple_idpass = v
        when 'AppleIDPassFormat'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @apple_idpass_format = v
        when 'CertificateFile'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @certificate_file = v
        when 'AppCertificateFile'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @app_certificate_file = v
        when 'PfxFilePassword'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @pfx_file_password = v
        when 'PfxFilePasswordFormat'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @pfx_file_password_format = v
        when 'NotaryAPIIssuerID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @notary_apiissuer_id = v
        when 'NotaryAPIKeyID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @notary_apikey_id = v
        when 'NotaryAPIKeyFile'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @notary_apikey_file = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Level'] = @level
      ret['SignLocally'] = @sign_locally
      ret['SSHServer'] = @sshserver
      ret['CertificateName'] = @certificate_name
      ret['AppCertificateName'] = @app_certificate_name
      ret['AppleID'] = @apple_id
      ret['AppleIDPass'] = @apple_idpass
      ret['AppleIDPassFormat'] = @apple_idpass_format
      ret['CertificateFile'] = @certificate_file
      ret['AppCertificateFile'] = @app_certificate_file
      ret['PfxFilePassword'] = @pfx_file_password
      ret['PfxFilePasswordFormat'] = @pfx_file_password_format
      ret['NotaryAPIIssuerID'] = @notary_apiissuer_id
      ret['NotaryAPIKeyID'] = @notary_apikey_id
      ret['NotaryAPIKeyFile'] = @notary_apikey_file
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
