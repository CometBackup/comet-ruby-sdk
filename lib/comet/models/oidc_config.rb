# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # OidcConfig is a typed class wrapper around the underlying Comet Server API data structure.
  class OidcConfig

    # @type [String] display_name
    attr_accessor :display_name

    # @type [Array<String>] hosts
    attr_accessor :hosts

    # @type [String] organization_id
    attr_accessor :organization_id

    # @type [String] provider
    attr_accessor :provider

    # @type [String] client_id
    attr_accessor :client_id

    # @type [String] client_secret
    attr_accessor :client_secret

    # @type [Boolean] skip_mfa
    attr_accessor :skip_mfa

    # @type [Array<String>] scopes
    attr_accessor :scopes

    # @type [Array<Comet::OidcClaim>] required_claims
    attr_accessor :required_claims

    # @type [String] generic_op_discovery_document_url
    attr_accessor :generic_op_discovery_document_url

    # @type [String] azure_adv2op_tenant_id
    attr_accessor :azure_adv2op_tenant_id

    # @type [String] google_op_hosted_domain
    attr_accessor :google_op_hosted_domain

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @display_name = ''
      @hosts = []
      @organization_id = ''
      @provider = ''
      @client_id = ''
      @client_secret = ''
      @scopes = []
      @required_claims = []
      @generic_op_discovery_document_url = ''
      @azure_adv2op_tenant_id = ''
      @google_op_hosted_domain = ''
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
        when 'DisplayName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @display_name = v
        when 'Hosts'
          if v.nil?
            @hosts = []
          else
            @hosts = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @hosts[i1] = v1
            end
          end
        when 'OrganizationID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @organization_id = v
        when 'Provider'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @provider = v
        when 'ClientID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @client_id = v
        when 'ClientSecret'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @client_secret = v
        when 'SkipMFA'
          @skip_mfa = v
        when 'Scopes'
          if v.nil?
            @scopes = []
          else
            @scopes = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @scopes[i1] = v1
            end
          end
        when 'RequiredClaims'
          if v.nil?
            @required_claims = []
          else
            @required_claims = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @required_claims[i1] = Comet::OidcClaim.new
              @required_claims[i1].from_hash(v1)
            end
          end
        when 'DiscoveryDocumentURL'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @generic_op_discovery_document_url = v
        when 'AzureTenantID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @azure_adv2op_tenant_id = v
        when 'GoogleHostedDomain'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @google_op_hosted_domain = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['DisplayName'] = @display_name
      unless @hosts.nil?
        ret['Hosts'] = @hosts
      end
      unless @organization_id.nil?
        ret['OrganizationID'] = @organization_id
      end
      ret['Provider'] = @provider
      ret['ClientID'] = @client_id
      ret['ClientSecret'] = @client_secret
      ret['SkipMFA'] = @skip_mfa
      unless @scopes.nil?
        ret['Scopes'] = @scopes
      end
      unless @required_claims.nil?
        ret['RequiredClaims'] = @required_claims
      end
      unless @generic_op_discovery_document_url.nil?
        ret['DiscoveryDocumentURL'] = @generic_op_discovery_document_url
      end
      unless @azure_adv2op_tenant_id.nil?
        ret['AzureTenantID'] = @azure_adv2op_tenant_id
      end
      unless @google_op_hosted_domain.nil?
        ret['GoogleHostedDomain'] = @google_op_hosted_domain
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
