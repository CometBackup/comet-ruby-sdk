# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # SearchResultFileInfo is a typed class wrapper around the underlying Comet Server API data structure.
  class SearchResultFileInfo

    # @type [String] path
    attr_accessor :path

    # @type [String] name
    attr_accessor :name

    # @type [String] type
    attr_accessor :type

    # @type [String] mode
    attr_accessor :mode

    # @type [String] mtime
    attr_accessor :mtime

    # @type [String] atime
    attr_accessor :atime

    # @type [String] ctime
    attr_accessor :ctime

    # @type [Number] size
    attr_accessor :size

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @path = ''
      @name = ''
      @type = ''
      @mode = ''
      @mtime = ''
      @atime = ''
      @ctime = ''
      @size = 0
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
        when 'path'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @path = v
        when 'name'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @name = v
        when 'type'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @type = v
        when 'mode'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @mode = v
        when 'mtime'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @mtime = v
        when 'atime'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @atime = v
        when 'ctime'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @ctime = v
        when 'size'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @size = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['path'] = @path
      ret['name'] = @name
      ret['type'] = @type
      ret['mode'] = @mode
      ret['mtime'] = @mtime
      ret['atime'] = @atime
      ret['ctime'] = @ctime
      ret['size'] = @size
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
