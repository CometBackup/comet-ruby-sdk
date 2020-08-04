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

  # SoftwareUpdateNewsResponse is a typed class wrapper around the underlying Comet Server API data structure.
  class SoftwareUpdateNewsResponse

    # @type [String] latest_stable
    attr_accessor :latest_stable

    # @type [String] latest_prerelease
    attr_accessor :latest_prerelease

    # @type [String] downloads_url
    attr_accessor :downloads_url

    # @type [Array<String>] whats_new
    attr_accessor :whats_new

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      @whats_new = []
      @unknown_json_fields = {}
    end

    # @param [String] json_string The complete object in JSON format
    def from_json(json_string)
      from_hash(JSON.parse(json_string))
    end

    # @param [Hash] obj The complete object as a Ruby hash
    def from_hash(obj)
      obj.each do |k, v|
        case k
        when 'latest_stable'
          raise TypeError 'expected string' unless v.is_a? String

          @latest_stable = v
        when 'latest_prerelease'
          raise TypeError 'expected string' unless v.is_a? String

          @latest_prerelease = v
        when 'downloads_url'
          raise TypeError 'expected string' unless v.is_a? String

          @downloads_url = v
        when 'updates_info'
          if v.nil?
            @whats_new = []
          else
            @whats_new = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError 'expected string' unless v1.is_a? String

              @whats_new[i1] = v1
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
      ret['latest_stable'] = @latest_stable
      ret['latest_prerelease'] = @latest_prerelease
      ret['downloads_url'] = @downloads_url
      ret['updates_info'] = @whats_new
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
