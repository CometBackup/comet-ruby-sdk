# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # ExternalAuthenticationSource is a typed class wrapper around the underlying Comet Server API data structure.
  class ExternalAuthenticationSource

    # @type [String] type
    attr_accessor :type

    # @type [String] description
    attr_accessor :description

    # @type [String] remote_address
    attr_accessor :remote_address

    # @type [String] username
    attr_accessor :username

    # @type [String] password
    attr_accessor :password

    # @type [Comet::ExternalLDAPAuthenticationSourceSettings] ldap
    attr_accessor :ldap

    # @type [Comet::OidcConfig] oidc
    attr_accessor :oidc

    # @type [Comet::B2VirtualStorageRoleSettings] b2
    attr_accessor :b2

    # @type [Comet::WasabiVirtualStorageRoleSettings] wasabi
    attr_accessor :wasabi

    # @type [Comet::CustomRemoteBucketSettings] custom
    attr_accessor :custom

    # @type [Comet::S3GenericVirtualStorageRole] s3
    attr_accessor :s3

    # Amazon AWS - Virtual Storage Role
    # @type [Comet::AmazonAWSVirtualStorageRoleSettings] aws
    attr_accessor :aws

    # @type [Comet::StorjVirtualStorageRoleSetting] storj
    attr_accessor :storj

    # @type [Comet::AdminUserPermissions] new_user_permissions
    attr_accessor :new_user_permissions

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @type = ''
      @description = ''
      @remote_address = ''
      @username = ''
      @password = ''
      @ldap = Comet::ExternalLDAPAuthenticationSourceSettings.new
      @oidc = Comet::OidcConfig.new
      @b2 = Comet::B2VirtualStorageRoleSettings.new
      @wasabi = Comet::WasabiVirtualStorageRoleSettings.new
      @custom = Comet::CustomRemoteBucketSettings.new
      @s3 = Comet::S3GenericVirtualStorageRole.new
      @aws = Comet::AmazonAWSVirtualStorageRoleSettings.new
      @storj = Comet::StorjVirtualStorageRoleSetting.new
      @new_user_permissions = Comet::AdminUserPermissions.new
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
        when 'Type'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @type = v
        when 'Description'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @description = v
        when 'RemoteAddress'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @remote_address = v
        when 'Username'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @username = v
        when 'Password'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @password = v
        when 'LDAP'
          @ldap = Comet::ExternalLDAPAuthenticationSourceSettings.new
          @ldap.from_hash(v)
        when 'OIDC'
          @oidc = Comet::OidcConfig.new
          @oidc.from_hash(v)
        when 'B2'
          @b2 = Comet::B2VirtualStorageRoleSettings.new
          @b2.from_hash(v)
        when 'Wasabi'
          @wasabi = Comet::WasabiVirtualStorageRoleSettings.new
          @wasabi.from_hash(v)
        when 'Custom'
          @custom = Comet::CustomRemoteBucketSettings.new
          @custom.from_hash(v)
        when 'S3'
          @s3 = Comet::S3GenericVirtualStorageRole.new
          @s3.from_hash(v)
        when 'AWS'
          @aws = Comet::AmazonAWSVirtualStorageRoleSettings.new
          @aws.from_hash(v)
        when 'Storj'
          @storj = Comet::StorjVirtualStorageRoleSetting.new
          @storj.from_hash(v)
        when 'NewUserPermissions'
          @new_user_permissions = Comet::AdminUserPermissions.new
          @new_user_permissions.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Type'] = @type
      ret['Description'] = @description
      unless @remote_address.nil?
        ret['RemoteAddress'] = @remote_address
      end
      unless @username.nil?
        ret['Username'] = @username
      end
      unless @password.nil?
        ret['Password'] = @password
      end
      unless @ldap.nil?
        ret['LDAP'] = @ldap
      end
      unless @oidc.nil?
        ret['OIDC'] = @oidc
      end
      unless @b2.nil?
        ret['B2'] = @b2
      end
      unless @wasabi.nil?
        ret['Wasabi'] = @wasabi
      end
      unless @custom.nil?
        ret['Custom'] = @custom
      end
      unless @s3.nil?
        ret['S3'] = @s3
      end
      unless @aws.nil?
        ret['AWS'] = @aws
      end
      unless @storj.nil?
        ret['Storj'] = @storj
      end
      ret['NewUserPermissions'] = @new_user_permissions
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
