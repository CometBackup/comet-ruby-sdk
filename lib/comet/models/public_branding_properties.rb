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

  # PublicBrandingProperties is a typed class wrapper around the underlying Comet Server API data structure.
  class PublicBrandingProperties

    # @type [String] product_name
    attr_accessor :product_name

    # @type [String] company_name
    attr_accessor :company_name

    # @type [String] help_url
    attr_accessor :help_url

    # @type [Boolean] help_is_popup
    attr_accessor :help_is_popup

    # @type [String] default_login_server_url
    attr_accessor :default_login_server_url

    # @type [String] tile_background_color
    attr_accessor :tile_background_color

    # @type [String] account_register_url
    attr_accessor :account_register_url

    # @type [Boolean] hide_background_logo
    attr_accessor :hide_background_logo

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @product_name = ""
      @company_name = ""
      @help_url = ""
      @default_login_server_url = ""
      @tile_background_color = ""
      @account_register_url = ""
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
        when 'ProductName'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @product_name = v
        when 'CompanyName'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @company_name = v
        when 'HelpURL'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @help_url = v
        when 'HelpIsPopup'
          @help_is_popup = v
        when 'DefaultLoginServerURL'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @default_login_server_url = v
        when 'TileBackgroundColor'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @tile_background_color = v
        when 'AccountRegisterURL'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @account_register_url = v
        when 'HideBackgroundLogo'
          @hide_background_logo = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['ProductName'] = @product_name
      ret['CompanyName'] = @company_name
      ret['HelpURL'] = @help_url
      ret['HelpIsPopup'] = @help_is_popup
      ret['DefaultLoginServerURL'] = @default_login_server_url
      ret['TileBackgroundColor'] = @tile_background_color
      ret['AccountRegisterURL'] = @account_register_url
      ret['HideBackgroundLogo'] = @hide_background_logo
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
