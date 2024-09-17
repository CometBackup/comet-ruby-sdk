# frozen_string_literal: true

# Copyright (c) 2020-2024 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # RestoreJobAdvancedOptions is a typed class wrapper around the underlying Comet Server API data structure.
  class RestoreJobAdvancedOptions

    # One of the RESTORETYPE_ constants
    # @type [Number] type
    attr_accessor :type

    # For RESTORETYPE_FILE
    # @type [Boolean] overwrite_existing_files
    attr_accessor :overwrite_existing_files

    # For RESTORETYPE_FILE. If set, OverwriteExistingFiles must be true
    # @type [Boolean] overwrite_if_newer
    attr_accessor :overwrite_if_newer

    # For RESTORETYPE_FILE. If set, OverwriteExistingFiles must be true
    # @type [Boolean] overwrite_if_different_content
    attr_accessor :overwrite_if_different_content

    # For RESTORETYPE_FILE. If set, OverwriteExistingFiles must be true. This can be set in combination
    # with other OverwriteIf options.
    # @type [Boolean] overwrite_force_permissions
    attr_accessor :overwrite_force_permissions

    # For RESTORETYPE_FILE. If set, DestPath must be blank
    # @type [Boolean] dest_is_original_location
    attr_accessor :dest_is_original_location

    # For RESTORETYPE_FILE or RESTORETYPE_PROCESS_xxx
    # @type [String] dest_path
    attr_accessor :dest_path

    # For RESTORETYPE_WINDISK only. Must have one entry for each selected restore path
    # @type [Array<String>] exact_dest_paths
    attr_accessor :exact_dest_paths

    # For RESTORETYPE_FILE_ARCHIVE or RESTORETYPE_PROCESS_ARCHIVE. Default 0 is *.tar, for backward
    # compatibility
    # @type [Number] archive_format
    attr_accessor :archive_format

    # Default disabled. For RESTORETYPE_FILE and RESTORETYPE_WINDISK. Used to continue the restore job
    # when unreadable data chunks are found.
    # Corresponds to the "Allow partial file restores (zero-out unrecoverable data)" option
    # This field is available in Comet 23.6.4 and later.
    # @type [Boolean] skip_unreadable_chunks
    attr_accessor :skip_unreadable_chunks

    # Default disabled. Used to store the index files on disk instead of in memory.
    # Corresponds to the "Prefer temporary files instead of RAM (slower)" option
    # This field is available in Comet 23.6.4 and later.
    # @type [Boolean] on_disk_indexes_key
    attr_accessor :on_disk_indexes_key

    # For RESTORETYPE_OFFICE365_CLOUD.
    # @type [Comet::Office365Credential] office_365credential
    attr_accessor :office_365credential

    # For RESTORETYPE_MYSQL
    # @type [String] username
    attr_accessor :username

    # For RESTORETYPE_MYSQL
    # @type [String] password
    attr_accessor :password

    # For RESTORETYPE_MYSQL
    # @type [String] host
    attr_accessor :host

    # For RESTORETYPE_MYSQL
    # @type [String] port
    attr_accessor :port

    # For RESTORETYPE_MYSQL
    # @type [Boolean] use_ssl
    attr_accessor :use_ssl

    # For RESTORETYPE_MYSQL i.e.: Self signed certs
    # @type [Boolean] ssl_allow_invalid
    attr_accessor :ssl_allow_invalid

    # For RESTORETYPE_MYSQL
    # @type [String] ssl_ca_file
    attr_accessor :ssl_ca_file

    # For RESTORETYPE_MYSQL
    # @type [String] ssl_crt_file
    attr_accessor :ssl_crt_file

    # For RESTORETYPE_MYSQL
    # @type [String] ssl_key_file
    attr_accessor :ssl_key_file

    # For RESTORETYPE_MSSQL.
    # @type [Comet::MSSQLLoginArgs] ms_sql_connection
    attr_accessor :ms_sql_connection

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
      @username = ''
      @password = ''
      @host = ''
      @port = ''
      @ssl_ca_file = ''
      @ssl_crt_file = ''
      @ssl_key_file = ''
      @ms_sql_connection = Comet::MSSQLLoginArgs.new
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
        when 'OverwriteIfNewer'
          @overwrite_if_newer = v
        when 'OverwriteIfDifferentContent'
          @overwrite_if_different_content = v
        when 'OverwriteForcePermissions'
          @overwrite_force_permissions = v
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
        when 'SkipUnreadableChunks'
          @skip_unreadable_chunks = v
        when 'OnDiskIndexesKey'
          @on_disk_indexes_key = v
        when 'Office365Credential'
          @office_365credential = Comet::Office365Credential.new
          @office_365credential.from_hash(v)
        when 'Username'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @username = v
        when 'Password'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @password = v
        when 'Host'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @host = v
        when 'Port'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @port = v
        when 'UseSsl'
          @use_ssl = v
        when 'SslAllowInvalid'
          @ssl_allow_invalid = v
        when 'SslCaFile'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @ssl_ca_file = v
        when 'SslCrtFile'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @ssl_crt_file = v
        when 'SslKeyFile'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @ssl_key_file = v
        when 'MsSqlConnection'
          @ms_sql_connection = Comet::MSSQLLoginArgs.new
          @ms_sql_connection.from_hash(v)
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
      ret['OverwriteIfNewer'] = @overwrite_if_newer
      ret['OverwriteIfDifferentContent'] = @overwrite_if_different_content
      ret['OverwriteForcePermissions'] = @overwrite_force_permissions
      ret['DestIsOriginalLocation'] = @dest_is_original_location
      ret['DestPath'] = @dest_path
      ret['ExactDestPaths'] = @exact_dest_paths
      ret['ArchiveFormat'] = @archive_format
      ret['SkipUnreadableChunks'] = @skip_unreadable_chunks
      ret['OnDiskIndexesKey'] = @on_disk_indexes_key
      unless @office_365credential.nil?
        ret['Office365Credential'] = @office_365credential
      end
      ret['Username'] = @username
      ret['Password'] = @password
      ret['Host'] = @host
      ret['Port'] = @port
      ret['UseSsl'] = @use_ssl
      ret['SslAllowInvalid'] = @ssl_allow_invalid
      ret['SslCaFile'] = @ssl_ca_file
      ret['SslCrtFile'] = @ssl_crt_file
      ret['SslKeyFile'] = @ssl_key_file
      unless @ms_sql_connection.nil?
        ret['MsSqlConnection'] = @ms_sql_connection
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
