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

  # RestoreJobAdvancedOptions is a typed class wrapper around the underlying Comet Server API data structure.
  class RestoreJobAdvancedOptions

    # @type [Number] type
    attr_accessor :type

    # @type [Boolean] overwrite_existing_files
    attr_accessor :overwrite_existing_files

    # @type [Boolean] dest_is_original_location
    attr_accessor :dest_is_original_location

    # @type [String] dest_path
    attr_accessor :dest_path

    # @type [Array<String>] exact_dest_paths
    attr_accessor :exact_dest_paths

    # @type [Number] archive_format
    attr_accessor :archive_format

    # @type [Comet::Office365Credential] office_365credential
    attr_accessor :office_365credential

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @type = 0
      @dest_path = ''
      @exact_dest_paths = []
      @archive_format = 0
      @office_365credential = Comet::Office365Credential.new
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
        when 'Type'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @type = v
        when 'OverwriteExistingFiles'
          @overwrite_existing_files = v
        when 'DestIsOriginalLocation'
          @dest_is_original_location = v
        when 'DestPath'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @dest_path = v
        when 'ExactDestPaths'
          if v.nil?
            @exact_dest_paths = []
          else
            @exact_dest_paths = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @exact_dest_paths[i1] = v1
            end
          end
        when 'ArchiveFormat'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @archive_format = v
        when 'Office365Credential'
          @office_365credential = Comet::Office365Credential.new
          @office_365credential.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Type'] = @type
      ret['OverwriteExistingFiles'] = @overwrite_existing_files
      ret['DestIsOriginalLocation'] = @dest_is_original_location
      ret['DestPath'] = @dest_path
      ret['ExactDestPaths'] = @exact_dest_paths
      ret['ArchiveFormat'] = @archive_format
      unless @office_365credential.nil?
        ret['Office365Credential'] = @office_365credential
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
