# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # WebDavDestinationLocation is a typed class wrapper around the underlying Comet Server API data structure.
  # This type is available in Comet 23.6.9 and later.
  class WebDavDestinationLocation

    # The URL of the WebDAV server, including http/https and any custom port
    # @type [String] dav_server
    attr_accessor :dav_server

    # The username for logging in to the WebDAV server
    # @type [String] user_name
    attr_accessor :user_name

    # The password for logging in to the WebDAV server
    # @type [String] access_key
    attr_accessor :access_key

    # The target directory path within the WebDAV server
    # @type [String] path
    attr_accessor :path

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @dav_server = ''
      @user_name = ''
      @access_key = ''
      @path = ''
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
        when 'DavServer'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @dav_server = v
        when 'UserName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @user_name = v
        when 'AccessKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @access_key = v
        when 'Path'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @path = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      unless @dav_server.nil?
        ret['DavServer'] = @dav_server
      end
      unless @user_name.nil?
        ret['UserName'] = @user_name
      end
      unless @access_key.nil?
        ret['AccessKey'] = @access_key
      end
      unless @path.nil?
        ret['Path'] = @path
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
