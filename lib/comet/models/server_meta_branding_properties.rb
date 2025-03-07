# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # ServerMetaBrandingProperties is a typed class wrapper around the underlying Comet Server API data structure.
  class ServerMetaBrandingProperties

    # @type [String] brand_name
    attr_accessor :brand_name

    # @type [String] product_name
    attr_accessor :product_name

    # If true, this Comet Server has an image configured for its main logo. You can access it from the
    # /gen/logo.img endpoint. If false, this Comet Server has text configured for its main logo.
    # @type [Boolean] has_image
    attr_accessor :has_image

    # A value that will change if the branding image (/gen/logo.img) changes. You can use this as a
    # cache key.
    # @type [String] image_etag
    attr_accessor :image_etag

    # Colour in RGB hex format (e.g. "#FFFFFF")
    # @type [String] top_color
    attr_accessor :top_color

    # Colour in RGB hex format (e.g. "#FFFFFF")
    # @type [String] accent_color
    attr_accessor :accent_color

    # @type [Boolean] hide_news_area
    attr_accessor :hide_news_area

    # @type [Boolean] allow_unauthenticated_downloads
    attr_accessor :allow_unauthenticated_downloads

    # @type [Boolean] allow_authenticated_downloads
    attr_accessor :allow_authenticated_downloads

    # @type [Number] prune_logs_after_days
    attr_accessor :prune_logs_after_days

    # @type [Number] expired_in_seconds
    attr_accessor :expired_in_seconds

    # @type [Array<Comet::ExternalAuthenticationSourceDisplay>] external_authentication_sources
    attr_accessor :external_authentication_sources

    # If true, this Comet Server currently has no admins or users.
    # @type [Boolean] server_is_empty
    attr_accessor :server_is_empty

    # @type [String] cloud_storage_name
    attr_accessor :cloud_storage_name

    # Will hide the "Pre-built software client" option from the server settings. Only properly enforced
    # when custom branding is enforced via the license.
    # @type [Boolean] admin_hide_pre_built_client_option
    attr_accessor :admin_hide_pre_built_client_option

    # Will hide Comet Storage from everywhere, including the admin view. Only properly enforced when
    # custom branding is enforced via the license.
    # @type [Boolean] admin_hide_branded_cloud_storage
    attr_accessor :admin_hide_branded_cloud_storage

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @brand_name = ''
      @product_name = ''
      @image_etag = ''
      @top_color = ''
      @accent_color = ''
      @prune_logs_after_days = 0
      @expired_in_seconds = 0
      @external_authentication_sources = []
      @cloud_storage_name = ''
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
        when 'BrandName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @brand_name = v
        when 'ProductName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @product_name = v
        when 'HasImage'
          @has_image = v
        when 'ImageEtag'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @image_etag = v
        when 'TopColor'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @top_color = v
        when 'AccentColor'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @accent_color = v
        when 'HideNewsArea'
          @hide_news_area = v
        when 'AllowUnauthenticatedDownloads'
          @allow_unauthenticated_downloads = v
        when 'AllowAuthenticatedDownloads'
          @allow_authenticated_downloads = v
        when 'PruneLogsAfterDays'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @prune_logs_after_days = v
        when 'ExpiredInSeconds'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @expired_in_seconds = v
        when 'ExternalAuthenticationSources'
          if v.nil?
            @external_authentication_sources = []
          else
            @external_authentication_sources = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @external_authentication_sources[i1] = Comet::ExternalAuthenticationSourceDisplay.new
              @external_authentication_sources[i1].from_hash(v1)
            end
          end
        when 'ServerIsEmpty'
          @server_is_empty = v
        when 'CloudStorageName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @cloud_storage_name = v
        when 'AdminHidePreBuiltClientOption'
          @admin_hide_pre_built_client_option = v
        when 'AdminHideBrandedCloudStorage'
          @admin_hide_branded_cloud_storage = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['BrandName'] = @brand_name
      ret['ProductName'] = @product_name
      ret['HasImage'] = @has_image
      ret['ImageEtag'] = @image_etag
      ret['TopColor'] = @top_color
      ret['AccentColor'] = @accent_color
      ret['HideNewsArea'] = @hide_news_area
      ret['AllowUnauthenticatedDownloads'] = @allow_unauthenticated_downloads
      ret['AllowAuthenticatedDownloads'] = @allow_authenticated_downloads
      ret['PruneLogsAfterDays'] = @prune_logs_after_days
      ret['ExpiredInSeconds'] = @expired_in_seconds
      unless @external_authentication_sources.nil?
        ret['ExternalAuthenticationSources'] = @external_authentication_sources
      end
      ret['ServerIsEmpty'] = @server_is_empty
      ret['CloudStorageName'] = @cloud_storage_name
      ret['AdminHidePreBuiltClientOption'] = @admin_hide_pre_built_client_option
      ret['AdminHideBrandedCloudStorage'] = @admin_hide_branded_cloud_storage
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
