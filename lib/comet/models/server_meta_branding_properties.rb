#!/usr/bin/env ruby --enable-frozen-string-literal
#
# Copyright (c) 2020-2021 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT
#
# frozen_string_literal: true

require 'json'

module Comet

  # ServerMetaBrandingProperties is a typed class wrapper around the underlying Comet Server API data structure.
  class ServerMetaBrandingProperties

    # @type [String] brand_name
    attr_accessor :brand_name

    # @type [String] product_name
    attr_accessor :product_name

    # @type [Boolean] has_image
    attr_accessor :has_image

    # @type [String] top_color
    attr_accessor :top_color

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

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @brand_name = ''
      @product_name = ''
      @top_color = ''
      @prune_logs_after_days = 0
      @expired_in_seconds = 0
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
        when 'TopColor'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @top_color = v
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
      ret['TopColor'] = @top_color
      ret['HideNewsArea'] = @hide_news_area
      ret['AllowUnauthenticatedDownloads'] = @allow_unauthenticated_downloads
      ret['AllowAuthenticatedDownloads'] = @allow_authenticated_downloads
      ret['PruneLogsAfterDays'] = @prune_logs_after_days
      ret['ExpiredInSeconds'] = @expired_in_seconds
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
