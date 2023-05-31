# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

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

    # Unix timestamp in seconds
    # @type [Number] start_time
    attr_accessor :start_time

    # Unix timestamp in seconds. Will be zero if the job is still running.
    # @type [Number] end_time
    attr_accessor :end_time

    # The Protected Item that this job is for
    # @type [String] source_guid
    attr_accessor :source_guid

    # The Storage Vault that this job is for
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

    # For Hyper-V and VMware backup jobs, the total number of virtual machines.
    # @type [Number] total_vm_count
    attr_accessor :total_vm_count

    # For Office 365 backup jobs, the total number of mailboxes.
    # @type [Number] total_mails_count
    attr_accessor :total_mails_count

    # For Office 365 backup jobs, the total number of SharePoint sites.
    # @type [Number] total_sites_count
    attr_accessor :total_sites_count

    # For Office 365 backup jobs, the calculated effective number of protected accounts.
    # @type [Number] total_accounts_count
    attr_accessor :total_accounts_count

    # For Office 365 backup jobs, the number of licensed mailboxes.
    # @type [Number] total_licensed_mails_count
    attr_accessor :total_licensed_mails_count

    # For Office 365 backup jobs, the number of unlicensed mailboxes.
    # @type [Number] total_unlicensed_mails_count
    attr_accessor :total_unlicensed_mails_count

    # If this field is present, it is possible to request cancellation of this job via the API.
    # @type [String] cancellation_id
    attr_accessor :cancellation_id

    # If this backup job is still running, additional partial-progress information may be present in
    # this field.
    # @type [Comet::BackupJobProgress] progress
    attr_accessor :progress

    # The size of the Storage Vault, as measured at the start of the job.
    # @type [Comet::SizeMeasurement] destination_size_start
    attr_accessor :destination_size_start

    # The size of the Storage Vault, as measured at the end of the job.
    # @type [Comet::SizeMeasurement] destination_size_end
    attr_accessor :destination_size_end

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @guid = ''
      @username = ''
      @classification = 0
      @status = 0
      @start_time = 0
      @end_time = 0
      @source_guid = ''
      @destination_guid = ''
      @device_id = ''
      @snapshot_id = ''
      @client_version = ''
      @total_directories = 0
      @total_files = 0
      @total_size = 0
      @total_chunks = 0
      @upload_size = 0
      @download_size = 0
      @total_vm_count = 0
      @total_mails_count = 0
      @total_sites_count = 0
      @total_accounts_count = 0
      @total_licensed_mails_count = 0
      @total_unlicensed_mails_count = 0
      @cancellation_id = ''
      @progress = Comet::BackupJobProgress.new
      @destination_size_start = Comet::SizeMeasurement.new
      @destination_size_end = Comet::SizeMeasurement.new
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
        when 'GUID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @guid = v
        when 'Username'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @username = v
        when 'Classification'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @classification = v
        when 'Status'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @status = v
        when 'StartTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @start_time = v
        when 'EndTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @end_time = v
        when 'SourceGUID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @source_guid = v
        when 'DestinationGUID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @destination_guid = v
        when 'DeviceID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @device_id = v
        when 'SnapshotID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @snapshot_id = v
        when 'ClientVersion'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @client_version = v
        when 'TotalDirectories'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @total_directories = v
        when 'TotalFiles'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @total_files = v
        when 'TotalSize'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @total_size = v
        when 'TotalChunks'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @total_chunks = v
        when 'UploadSize'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @upload_size = v
        when 'DownloadSize'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @download_size = v
        when 'TotalVmCount'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @total_vm_count = v
        when 'TotalMailsCount'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @total_mails_count = v
        when 'TotalSitesCount'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @total_sites_count = v
        when 'TotalAccountsCount'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @total_accounts_count = v
        when 'TotalLicensedMailsCount'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @total_licensed_mails_count = v
        when 'TotalUnlicensedMailsCount'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @total_unlicensed_mails_count = v
        when 'CancellationID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @cancellation_id = v
        when 'Progress'
          @progress = Comet::BackupJobProgress.new
          @progress.from_hash(v)
        when 'DestinationSizeStart'
          @destination_size_start = Comet::SizeMeasurement.new
          @destination_size_start.from_hash(v)
        when 'DestinationSizeEnd'
          @destination_size_end = Comet::SizeMeasurement.new
          @destination_size_end.from_hash(v)
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
      unless @total_vm_count.nil?
        ret['TotalVmCount'] = @total_vm_count
      end
      unless @total_mails_count.nil?
        ret['TotalMailsCount'] = @total_mails_count
      end
      unless @total_sites_count.nil?
        ret['TotalSitesCount'] = @total_sites_count
      end
      unless @total_accounts_count.nil?
        ret['TotalAccountsCount'] = @total_accounts_count
      end
      unless @total_licensed_mails_count.nil?
        ret['TotalLicensedMailsCount'] = @total_licensed_mails_count
      end
      unless @total_unlicensed_mails_count.nil?
        ret['TotalUnlicensedMailsCount'] = @total_unlicensed_mails_count
      end
      unless @cancellation_id.nil?
        ret['CancellationID'] = @cancellation_id
      end
      unless @progress.nil?
        ret['Progress'] = @progress
      end
      unless @destination_size_start.nil?
        ret['DestinationSizeStart'] = @destination_size_start
      end
      unless @destination_size_end.nil?
        ret['DestinationSizeEnd'] = @destination_size_end
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
