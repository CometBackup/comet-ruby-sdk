# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # PrivateBrandingProperties is a typed class wrapper around the underlying Comet Server API data structure.
  class PrivateBrandingProperties

    # One of the CLIENTBRANDINGBUILD_ constants
    # @type [Number] build_mode
    attr_accessor :build_mode

    # @type [String] path_ico_file
    attr_accessor :path_ico_file

    # @type [String] path_icns_file
    attr_accessor :path_icns_file

    # @type [String] path_menu_bar_icns_file
    attr_accessor :path_menu_bar_icns_file

    # @type [String] path_eula_rtf
    attr_accessor :path_eula_rtf

    # @type [String] path_tile_png
    attr_accessor :path_tile_png

    # @type [String] path_header_image
    attr_accessor :path_header_image

    # @type [String] path_app_icon_image
    attr_accessor :path_app_icon_image

    # @type [String] package_identifier
    attr_accessor :package_identifier

    # One of the WINDOWSCODESIGN_METHOD_ constants
    # @type [Number] windows_code_sign_method
    attr_accessor :windows_code_sign_method

    # @type [String] windows_code_sign_pkcs12file_path
    attr_accessor :windows_code_sign_pkcs12file_path

    # One of the ENCRYPTIONMETHOD_ constants
    # @type [Number] windows_code_sign_pkcs12password_format
    attr_accessor :windows_code_sign_pkcs12password_format

    # @type [String] windows_code_sign_pkcs12password
    attr_accessor :windows_code_sign_pkcs12password

    # @type [String] windows_code_sign_pkcs11engine
    attr_accessor :windows_code_sign_pkcs11engine

    # @type [String] windows_code_sign_pkcs11module
    attr_accessor :windows_code_sign_pkcs11module

    # This field was deprecated between 23.3.0 and 23.6.x, but is now used again.
    # @type [String] windows_code_sign_pkcs11certfile
    attr_accessor :windows_code_sign_pkcs11certfile

    # @type [String] windows_code_sign_pkcs11key_id
    attr_accessor :windows_code_sign_pkcs11key_id

    # One of the ENCRYPTIONMETHOD_ constants
    # @type [Number] windows_code_sign_pkcs11password_format
    attr_accessor :windows_code_sign_pkcs11password_format

    # @type [String] windows_code_sign_pkcs11password
    attr_accessor :windows_code_sign_pkcs11password

    # @type [String] windows_code_sign_azure_vault_name
    attr_accessor :windows_code_sign_azure_vault_name

    # @type [String] windows_code_sign_azure_cert_name
    attr_accessor :windows_code_sign_azure_cert_name

    # @type [String] windows_code_sign_azure_app_id
    attr_accessor :windows_code_sign_azure_app_id

    # One of the ENCRYPTIONMETHOD_ constants
    # @type [Number] windows_code_sign_azure_app_secret_format
    attr_accessor :windows_code_sign_azure_app_secret_format

    # @type [String] windows_code_sign_azure_app_secret
    attr_accessor :windows_code_sign_azure_app_secret

    # @type [String] windows_code_sign_azure_tenant_id
    attr_accessor :windows_code_sign_azure_tenant_id

    # URL of the SAS Relic server, with protocol (https://) and trailing slash
    # @type [String] windows_code_sign_relic_server_url
    attr_accessor :windows_code_sign_relic_server_url

    # The SAS Relic client keypair in PEM format
    # @type [String] windows_code_sign_relic_keypair_file
    attr_accessor :windows_code_sign_relic_keypair_file

    # The name of the key to select on the remote SAS Relic server
    # @type [String] windows_code_sign_relic_key_name
    attr_accessor :windows_code_sign_relic_key_name

    # @type [Comet::MacOSCodeSignProperties] mac_oscode_sign
    attr_accessor :mac_oscode_sign

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @build_mode = 0
      @path_ico_file = ''
      @path_icns_file = ''
      @path_menu_bar_icns_file = ''
      @path_eula_rtf = ''
      @path_tile_png = ''
      @path_header_image = ''
      @path_app_icon_image = ''
      @package_identifier = ''
      @windows_code_sign_method = 0
      @windows_code_sign_pkcs12file_path = ''
      @windows_code_sign_pkcs12password_format = 0
      @windows_code_sign_pkcs12password = ''
      @windows_code_sign_pkcs11engine = ''
      @windows_code_sign_pkcs11module = ''
      @windows_code_sign_pkcs11certfile = ''
      @windows_code_sign_pkcs11key_id = ''
      @windows_code_sign_pkcs11password_format = 0
      @windows_code_sign_pkcs11password = ''
      @windows_code_sign_azure_vault_name = ''
      @windows_code_sign_azure_cert_name = ''
      @windows_code_sign_azure_app_id = ''
      @windows_code_sign_azure_app_secret_format = 0
      @windows_code_sign_azure_app_secret = ''
      @windows_code_sign_azure_tenant_id = ''
      @windows_code_sign_relic_server_url = ''
      @windows_code_sign_relic_keypair_file = ''
      @windows_code_sign_relic_key_name = ''
      @mac_oscode_sign = Comet::MacOSCodeSignProperties.new
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
        when 'BuildMode'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @build_mode = v
        when 'PathIcoFile'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @path_ico_file = v
        when 'PathIcnsFile'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @path_icns_file = v
        when 'PathMenuBarIcnsFile'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @path_menu_bar_icns_file = v
        when 'PathEulaRtf'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @path_eula_rtf = v
        when 'PathTilePng'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @path_tile_png = v
        when 'PathHeaderImage'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @path_header_image = v
        when 'PathAppIconImage'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @path_app_icon_image = v
        when 'PackageIdentifier'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @package_identifier = v
        when 'WindowsCodeSignMethod'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @windows_code_sign_method = v
        when 'WindowsCodeSignPKCS12FilePath'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @windows_code_sign_pkcs12file_path = v
        when 'WindowsCodeSignPKCS12PasswordFormat'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @windows_code_sign_pkcs12password_format = v
        when 'WindowsCodeSignPKCS12Password'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @windows_code_sign_pkcs12password = v
        when 'WindowsCodeSignPKCS11Engine'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @windows_code_sign_pkcs11engine = v
        when 'WindowsCodeSignPKCS11Module'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @windows_code_sign_pkcs11module = v
        when 'WindowsCodeSignPKCS11Certfile'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @windows_code_sign_pkcs11certfile = v
        when 'WindowsCodeSignPKCS11KeyID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @windows_code_sign_pkcs11key_id = v
        when 'WindowsCodeSignPKCS11PasswordFormat'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @windows_code_sign_pkcs11password_format = v
        when 'WindowsCodeSignPKCS11Password'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @windows_code_sign_pkcs11password = v
        when 'WindowsCodeSignAzureVaultName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @windows_code_sign_azure_vault_name = v
        when 'WindowsCodeSignAzureCertName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @windows_code_sign_azure_cert_name = v
        when 'WindowsCodeSignAzureAppID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @windows_code_sign_azure_app_id = v
        when 'WindowsCodeSignAzureAppSecretFormat'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @windows_code_sign_azure_app_secret_format = v
        when 'WindowsCodeSignAzureAppSecret'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @windows_code_sign_azure_app_secret = v
        when 'WindowsCodeSignAzureTenantID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @windows_code_sign_azure_tenant_id = v
        when 'WindowsCodeSignRelicServerURL'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @windows_code_sign_relic_server_url = v
        when 'WindowsCodeSignRelicKeypairFile'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @windows_code_sign_relic_keypair_file = v
        when 'WindowsCodeSignRelicKeyName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @windows_code_sign_relic_key_name = v
        when 'MacOSCodeSign'
          @mac_oscode_sign = Comet::MacOSCodeSignProperties.new
          @mac_oscode_sign.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['BuildMode'] = @build_mode
      ret['PathIcoFile'] = @path_ico_file
      ret['PathIcnsFile'] = @path_icns_file
      ret['PathMenuBarIcnsFile'] = @path_menu_bar_icns_file
      ret['PathEulaRtf'] = @path_eula_rtf
      ret['PathTilePng'] = @path_tile_png
      ret['PathHeaderImage'] = @path_header_image
      ret['PathAppIconImage'] = @path_app_icon_image
      ret['PackageIdentifier'] = @package_identifier
      ret['WindowsCodeSignMethod'] = @windows_code_sign_method
      ret['WindowsCodeSignPKCS12FilePath'] = @windows_code_sign_pkcs12file_path
      ret['WindowsCodeSignPKCS12PasswordFormat'] = @windows_code_sign_pkcs12password_format
      ret['WindowsCodeSignPKCS12Password'] = @windows_code_sign_pkcs12password
      ret['WindowsCodeSignPKCS11Engine'] = @windows_code_sign_pkcs11engine
      ret['WindowsCodeSignPKCS11Module'] = @windows_code_sign_pkcs11module
      ret['WindowsCodeSignPKCS11Certfile'] = @windows_code_sign_pkcs11certfile
      ret['WindowsCodeSignPKCS11KeyID'] = @windows_code_sign_pkcs11key_id
      ret['WindowsCodeSignPKCS11PasswordFormat'] = @windows_code_sign_pkcs11password_format
      ret['WindowsCodeSignPKCS11Password'] = @windows_code_sign_pkcs11password
      ret['WindowsCodeSignAzureVaultName'] = @windows_code_sign_azure_vault_name
      ret['WindowsCodeSignAzureCertName'] = @windows_code_sign_azure_cert_name
      ret['WindowsCodeSignAzureAppID'] = @windows_code_sign_azure_app_id
      ret['WindowsCodeSignAzureAppSecretFormat'] = @windows_code_sign_azure_app_secret_format
      ret['WindowsCodeSignAzureAppSecret'] = @windows_code_sign_azure_app_secret
      ret['WindowsCodeSignAzureTenantID'] = @windows_code_sign_azure_tenant_id
      ret['WindowsCodeSignRelicServerURL'] = @windows_code_sign_relic_server_url
      ret['WindowsCodeSignRelicKeypairFile'] = @windows_code_sign_relic_keypair_file
      ret['WindowsCodeSignRelicKeyName'] = @windows_code_sign_relic_key_name
      ret['MacOSCodeSign'] = @mac_oscode_sign
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
