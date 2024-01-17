# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # Organization is a typed class wrapper around the underlying Comet Server API data structure.
  class Organization

    # @type [Hash{String => Comet::FileOption}] audit_file_options
    attr_accessor :audit_file_options

    # @type [Comet::BrandingOptions] branding
    attr_accessor :branding

    # @type [Comet::ConstellationRoleOptions] constellation_role
    attr_accessor :constellation_role

    # @type [Comet::EmailOptions] email
    attr_accessor :email

    # @type [Array<String>] experimental_options
    attr_accessor :experimental_options

    # @type [Array<String>] hosts
    attr_accessor :hosts

    # @type [String] name
    attr_accessor :name

    # @type [Boolean] is_suspended
    attr_accessor :is_suspended

    # @type [Array<Comet::PSAConfig>] psaconfigs
    attr_accessor :psaconfigs

    # @type [Array<Comet::RemoteStorageOption>] remote_storage
    attr_accessor :remote_storage

    # @type [Comet::SoftwareBuildRoleOptions] software_build_role
    attr_accessor :software_build_role

    # @type [Hash{String => Comet::WebhookOption}] webhook_options
    attr_accessor :webhook_options

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @audit_file_options = {}
      @branding = Comet::BrandingOptions.new
      @constellation_role = Comet::ConstellationRoleOptions.new
      @email = Comet::EmailOptions.new
      @experimental_options = []
      @hosts = []
      @name = ''
      @psaconfigs = []
      @remote_storage = []
      @software_build_role = Comet::SoftwareBuildRoleOptions.new
      @webhook_options = {}
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
        when 'AuditFileOptions'
          @audit_file_options = {}
          if v.nil?
            @audit_file_options = {}
          else
            v.each do |k1, v1|
              @audit_file_options[k1] = Comet::FileOption.new
              @audit_file_options[k1].from_hash(v1)
            end
          end
        when 'Branding'
          @branding = Comet::BrandingOptions.new
          @branding.from_hash(v)
        when 'ConstellationRole'
          @constellation_role = Comet::ConstellationRoleOptions.new
          @constellation_role.from_hash(v)
        when 'Email'
          @email = Comet::EmailOptions.new
          @email.from_hash(v)
        when 'ExperimentalOptions'
          if v.nil?
            @experimental_options = []
          else
            @experimental_options = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @experimental_options[i1] = v1
            end
          end
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
        when 'Name'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @name = v
        when 'IsSuspended'
          @is_suspended = v
        when 'PSAConfigs'
          if v.nil?
            @psaconfigs = []
          else
            @psaconfigs = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @psaconfigs[i1] = Comet::PSAConfig.new
              @psaconfigs[i1].from_hash(v1)
            end
          end
        when 'RemoteStorage'
          if v.nil?
            @remote_storage = []
          else
            @remote_storage = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @remote_storage[i1] = Comet::RemoteStorageOption.new
              @remote_storage[i1].from_hash(v1)
            end
          end
        when 'SoftwareBuildRole'
          @software_build_role = Comet::SoftwareBuildRoleOptions.new
          @software_build_role.from_hash(v)
        when 'WebhookOptions'
          @webhook_options = {}
          if v.nil?
            @webhook_options = {}
          else
            v.each do |k1, v1|
              @webhook_options[k1] = Comet::WebhookOption.new
              @webhook_options[k1].from_hash(v1)
            end
          end
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['AuditFileOptions'] = @audit_file_options
      ret['Branding'] = @branding
      ret['ConstellationRole'] = @constellation_role
      ret['Email'] = @email
      unless @experimental_options.nil?
        ret['ExperimentalOptions'] = @experimental_options
      end
      ret['Hosts'] = @hosts
      ret['Name'] = @name
      ret['IsSuspended'] = @is_suspended
      ret['PSAConfigs'] = @psaconfigs
      ret['RemoteStorage'] = @remote_storage
      ret['SoftwareBuildRole'] = @software_build_role
      ret['WebhookOptions'] = @webhook_options
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
