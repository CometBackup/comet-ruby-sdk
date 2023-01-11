# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # SelfBackupExportOptions is a typed class wrapper around the underlying Comet Server API data structure.
  class SelfBackupExportOptions

    # @type [Comet::DestinationLocation] location
    attr_accessor :location

    # @type [String] encryption_key
    attr_accessor :encryption_key

    # @type [Number] encryption_key_format
    attr_accessor :encryption_key_format

    # @type [Number] compression
    attr_accessor :compression

    # @type [Boolean] exclude_jobs_db
    attr_accessor :exclude_jobs_db

    # @type [String] restrict_to_single_org_id
    attr_accessor :restrict_to_single_org_id

    # @type [Number] index
    attr_accessor :index

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @location = Comet::DestinationLocation.new
      @encryption_key = ''
      @encryption_key_format = 0
      @compression = 0
      @restrict_to_single_org_id = ''
      @index = 0
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
        when 'Location'
          @location = Comet::DestinationLocation.new
          @location.from_hash(v)
        when 'EncryptionKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @encryption_key = v
        when 'EncryptionKeyFormat'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @encryption_key_format = v
        when 'Compression'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @compression = v
        when 'ExcludeJobsDB'
          @exclude_jobs_db = v
        when 'RestrictToSingleOrgID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @restrict_to_single_org_id = v
        when 'Index'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @index = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Location'] = @location
      ret['EncryptionKey'] = @encryption_key
      ret['EncryptionKeyFormat'] = @encryption_key_format
      ret['Compression'] = @compression
      ret['ExcludeJobsDB'] = @exclude_jobs_db
      unless @restrict_to_single_org_id.nil?
        ret['RestrictToSingleOrgID'] = @restrict_to_single_org_id
      end
      ret['Index'] = @index
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
