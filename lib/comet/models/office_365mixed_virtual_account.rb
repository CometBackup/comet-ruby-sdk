# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # Office365MixedVirtualAccount is a typed class wrapper around the underlying Comet Server API data structure.
  class Office365MixedVirtualAccount

    # @type [String] default_drive_id
    attr_accessor :default_drive_id

    # @type [String] display_name
    attr_accessor :display_name

    # @type [Number] enabled_service_option
    attr_accessor :enabled_service_option

    # @type [String] id
    attr_accessor :id

    # @type [String] job_title
    attr_accessor :job_title

    # @type [String] mail
    attr_accessor :mail

    # @type [String] site_id
    attr_accessor :site_id

    # @type [Number] type
    attr_accessor :type

    # @type [String] user_principal_name
    attr_accessor :user_principal_name

    # @type [String] web_id
    attr_accessor :web_id

    # @type [String] web_url
    attr_accessor :web_url

    # @type [Array<String>] members
    attr_accessor :members

    # @type [Number] service_options
    attr_accessor :service_options

    # @type [Number] member_service_options
    attr_accessor :member_service_options

    # @type [Boolean] has_license
    attr_accessor :has_license

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @default_drive_id = ''
      @display_name = ''
      @enabled_service_option = 0
      @id = ''
      @job_title = ''
      @mail = ''
      @site_id = ''
      @type = 0
      @user_principal_name = ''
      @web_id = ''
      @web_url = ''
      @members = []
      @service_options = 0
      @member_service_options = 0
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
        when 'DefaultDriveID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @default_drive_id = v
        when 'DisplayName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @display_name = v
        when 'EnabledServiceOption'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @enabled_service_option = v
        when 'id'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @id = v
        when 'JobTitle'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @job_title = v
        when 'Mail'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @mail = v
        when 'SiteID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @site_id = v
        when 'Type'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @type = v
        when 'UserPrincipalName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @user_principal_name = v
        when 'WebID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @web_id = v
        when 'WebURL'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @web_url = v
        when 'Members'
          if v.nil?
            @members = []
          else
            @members = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @members[i1] = v1
            end
          end
        when 'ServiceOptions'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @service_options = v
        when 'MemberServiceOptions'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @member_service_options = v
        when 'hasLicense'
          @has_license = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      unless @default_drive_id.nil?
        ret['DefaultDriveID'] = @default_drive_id
      end
      unless @display_name.nil?
        ret['DisplayName'] = @display_name
      end
      unless @enabled_service_option.nil?
        ret['EnabledServiceOption'] = @enabled_service_option
      end
      ret['id'] = @id
      unless @job_title.nil?
        ret['JobTitle'] = @job_title
      end
      unless @mail.nil?
        ret['Mail'] = @mail
      end
      unless @site_id.nil?
        ret['SiteID'] = @site_id
      end
      unless @type.nil?
        ret['Type'] = @type
      end
      unless @user_principal_name.nil?
        ret['UserPrincipalName'] = @user_principal_name
      end
      unless @web_id.nil?
        ret['WebID'] = @web_id
      end
      unless @web_url.nil?
        ret['WebURL'] = @web_url
      end
      unless @members.nil?
        ret['Members'] = @members
      end
      unless @service_options.nil?
        ret['ServiceOptions'] = @service_options
      end
      unless @member_service_options.nil?
        ret['MemberServiceOptions'] = @member_service_options
      end
      unless @has_license.nil?
        ret['hasLicense'] = @has_license
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
