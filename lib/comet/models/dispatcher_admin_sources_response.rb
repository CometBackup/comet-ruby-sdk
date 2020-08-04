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

  # DispatcherAdminSourcesResponse is a typed class wrapper around the underlying Comet Server API data structure.
  class DispatcherAdminSourcesResponse

    # @type [Number] status
    attr_accessor :status

    # @type [String] message
    attr_accessor :message

    # @type [Hash{String => String}] import_sources
    attr_accessor :import_sources

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      @import_sources = {}
      @unknown_json_fields = {}
    end

    # @param [String] json_string The complete object in JSON format
    def from_json(json_string)
      raise TypeError 'expected string' unless json_string.is_a? String

      from_hash(JSON.parse(json_string))
    end

    # @param [Hash] obj The complete object as a Ruby hash
    def from_hash(obj)
      raise TypeError 'expected hash' unless obj.is_a? Hash

      obj.each do |k, v|
        case k
        when 'Status'
          @status = v
        when 'Message'
          raise TypeError 'expected string' unless v.is_a? String

          @message = v
        when 'ImportSources'
          @import_sources = {}
          if v.nil?
            @import_sources = {}
          else
            v.each do |k1, v1|
              raise TypeError 'expected string' unless v1.is_a? String

              @import_sources[k1] = v1
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
      ret['Status'] = @status
      ret['Message'] = @message
      ret['ImportSources'] = @import_sources
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