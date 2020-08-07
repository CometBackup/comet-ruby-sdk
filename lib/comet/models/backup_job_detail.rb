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

  # BackupJobDetail is a typed class wrapper around the underlying Comet Server API data structure.
  class BackupJobDetail

    # @type [String] guid
    attr_accessor :guid

    # @type [String] username
    attr_accessor :username

    # @type [Number] classification
    attr_accessor :classification

    # @type [Number] status
    attr_accessor :status

    # @type [Number] start_time
    attr_accessor :start_time

    # @type [Number] end_time
    attr_accessor :end_time

    # @type [String] source_guid
    attr_accessor :source_guid

    # @type [String] destination_guid
    attr_accessor :destination_guid

    # @type [String] device_id
    attr_accessor :device_id

    # @type [String] snapshot_id
    attr_accessor :snapshot_id

    # @type [String] client_version
    attr_accessor :client_version

    # @type [Number] total_directories
    attr_accessor :total_directories

    # @type [Number] total_files
    attr_accessor :total_files

    # @type [Number] total_size
    attr_accessor :total_size

    # @type [Number] total_chunks
    attr_accessor :total_chunks

    # @type [Number] upload_size
    attr_accessor :upload_size

    # @type [Number] download_size
    attr_accessor :download_size

    # @type [String] cancellation_id
    attr_accessor :cancellation_id

    # @type [Comet::BackupJobProgress] progress
    attr_accessor :progress

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
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
        when 'GUID'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @guid = v
        when 'Username'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @username = v
        when 'Classification'
          @classification = v
        when 'Status'
          @status = v
        when 'StartTime'
          @start_time = v
        when 'EndTime'
          @end_time = v
        when 'SourceGUID'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @source_guid = v
        when 'DestinationGUID'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @destination_guid = v
        when 'DeviceID'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @device_id = v
        when 'SnapshotID'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @snapshot_id = v
        when 'ClientVersion'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @client_version = v
        when 'TotalDirectories'
          @total_directories = v
        when 'TotalFiles'
          @total_files = v
        when 'TotalSize'
          @total_size = v
        when 'TotalChunks'
          @total_chunks = v
        when 'UploadSize'
          @upload_size = v
        when 'DownloadSize'
          @download_size = v
        when 'CancellationID'
          raise TypeError "'v' expected String, got #{v.class}" unless v.is_a? String

          @cancellation_id = v
        when 'Progress'
          @progress = Comet::BackupJobProgress.new
          @progress.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['GUID'] = @guid
      ret['Username'] = @username
      ret['Classification'] = @classification
      ret['Status'] = @status
      ret['StartTime'] = @start_time
      ret['EndTime'] = @end_time
      ret['SourceGUID'] = @source_guid
      ret['DestinationGUID'] = @destination_guid
      ret['DeviceID'] = @device_id
      unless @snapshot_id.nil?
        ret['SnapshotID'] = @snapshot_id
      end
      ret['ClientVersion'] = @client_version
      ret['TotalDirectories'] = @total_directories
      ret['TotalFiles'] = @total_files
      ret['TotalSize'] = @total_size
      ret['TotalChunks'] = @total_chunks
      ret['UploadSize'] = @upload_size
      ret['DownloadSize'] = @download_size
      unless @cancellation_id.nil?
        ret['CancellationID'] = @cancellation_id
      end
      unless @progress.nil?
        ret['Progress'] = @progress
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
