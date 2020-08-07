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

  # WebInterfaceBrandingProperties is a typed class wrapper around the underlying Comet Server API data structure.
  class WebInterfaceBrandingProperties

    # @type [String] brand_name
    attr_accessor :brand_name

    # @type [String] logo_image
    attr_accessor :logo_image

    # @type [String] top_color
    attr_accessor :top_color

    # @type [String] favicon
    attr_accessor :favicon

    # @type [Boolean] hide_news_area
    attr_accessor :hide_news_area

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @brand_name = ""
      @logo_image = ""
      @top_color = ""
      @favicon = ""
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
        when 'BrandName'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @brand_name = v
        when 'LogoImage'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @logo_image = v
        when 'TopColor'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @top_color = v
        when 'Favicon'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @favicon = v
        when 'HideNewsArea'
          @hide_news_area = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['BrandName'] = @brand_name
      ret['LogoImage'] = @logo_image
      ret['TopColor'] = @top_color
      ret['Favicon'] = @favicon
      ret['HideNewsArea'] = @hide_news_area
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
