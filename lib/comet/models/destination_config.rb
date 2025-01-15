# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # DestinationConfig is a typed class wrapper around the underlying Comet Server API data structure.
  class DestinationConfig

    # @type [String] description
    attr_accessor :description

    # Unix timestamp in seconds
    # @type [Number] create_time
    attr_accessor :create_time

    # Unix timestamp in seconds
    # @type [Number] modify_time
    attr_accessor :modify_time

    # Custom commands to run before the job
    # @type [Array<String>] pre_exec
    attr_accessor :pre_exec

    # Custom commands to run after taking a disk snapshot
    # @type [Array<String>] thaw_exec
    attr_accessor :thaw_exec

    # Custom commands to run after the job
    # @type [Array<String>] post_exec
    attr_accessor :post_exec

    # One of the DESTINATIONTYPE_ constants
    # @type [Number] destination_type
    attr_accessor :destination_type

    # The URL for the target Comet Server Storage Role, including http/https and trailing slash
    # @type [String] comet_server
    attr_accessor :comet_server

    # @type [String] comet_bucket
    attr_accessor :comet_bucket

    # @type [String] comet_bucket_key
    attr_accessor :comet_bucket_key

    # @type [String] s3server
    attr_accessor :s3server

    # @type [Boolean] s3uses_tls
    attr_accessor :s3uses_tls

    # @type [String] s3access_key
    attr_accessor :s3access_key

    # @type [String] s3secret_key
    attr_accessor :s3secret_key

    # @type [String] s3bucket_name
    attr_accessor :s3bucket_name

    # @type [String] s3subdir
    attr_accessor :s3subdir

    # @type [String] s3custom_region
    attr_accessor :s3custom_region

    # If true, use legacy v2 signing. If false (default), use modern v4 signing
    # @type [Boolean] s3uses_v2signing
    attr_accessor :s3uses_v2signing

    # @type [Boolean] s3remove_deleted
    attr_accessor :s3remove_deleted

    # @type [Number] s3object_lock_mode
    attr_accessor :s3object_lock_mode

    # @type [Number] s3object_lock_days
    attr_accessor :s3object_lock_days

    # @type [String] sftpserver
    attr_accessor :sftpserver

    # @type [String] sftpusername
    attr_accessor :sftpusername

    # The directory on the SFTP server in which data is stored.
    # @type [String] sftpremote_path
    attr_accessor :sftpremote_path

    # One of the DESTINATION_SFTP_AUTHMODE_ constants
    # @type [Number] sftpauth_mode
    attr_accessor :sftpauth_mode

    # For use with DESTINATION_SFTP_AUTHMODE_PASSWORD only: the SSH password to connect with
    # @type [String] sftppassword
    attr_accessor :sftppassword

    # For use with DESTINATION_SFTP_AUTHMODE_PRIVATEKEY only: the SSH private key to connect with, in
    # OpenSSH format.
    # @type [String] sftpprivate_key
    attr_accessor :sftpprivate_key

    # If true, then the SFTPCustomAuth_KnownHostsFile will be used to verify the remote SSH server's
    # host key, using Trust On First Use (TOFU).
    # @type [Boolean] sftpcustom_auth__use_known_hosts_file
    attr_accessor :sftpcustom_auth__use_known_hosts_file

    # If SFTPCustomAuth_UseKnownHostFile is true, the path to the SSH known_hosts file.
    # @type [String] sftpcustom_auth__known_hosts_file
    attr_accessor :sftpcustom_auth__known_hosts_file

    # @type [String] ftpserver
    attr_accessor :ftpserver

    # @type [String] ftpusername
    attr_accessor :ftpusername

    # @type [String] ftppassword
    attr_accessor :ftppassword

    # If true, store data in the default home directory given by the FTP server. If false, store data in
    # the FTPCustomBaseDirectory path.
    # @type [Boolean] ftpbase_use_home_directory
    attr_accessor :ftpbase_use_home_directory

    # If FTPBaseUseHomeDirectory is false, this field controls the path where data is stored.
    # @type [String] ftpcustom_base_directory
    attr_accessor :ftpcustom_base_directory

    # Control whether this is plaintext FTP or secure FTPS by using one of the FTPS_MODE_ constants.
    # @type [Number] ftpsmode
    attr_accessor :ftpsmode

    # @type [Number] ftpport
    attr_accessor :ftpport

    # If set to zero, uses a system default value that is not unlimited.
    # @type [Number] ftpmax_connections
    attr_accessor :ftpmax_connections

    # @type [Boolean] ftpaccept_invalid_ssl
    attr_accessor :ftpaccept_invalid_ssl

    # @type [String] azbaccount_name
    attr_accessor :azbaccount_name

    # @type [String] azbaccount_key
    attr_accessor :azbaccount_key

    # @type [String] azbcontainer
    attr_accessor :azbcontainer

    # The base URL for the Azure Blob Storage service. Leave blank to use the global default URL.
    # @type [String] azbrealm
    attr_accessor :azbrealm

    # @type [String] azbprefix
    attr_accessor :azbprefix

    # @type [String] localcopy_path
    attr_accessor :localcopy_path

    # If logging in to a Windows network share (SMB/CIFS) is required, enter the username here.
    # @type [String] localcopy_win_smbusername
    attr_accessor :localcopy_win_smbusername

    # If logging in to a Windows network share (SMB/CIFS) is required, enter the password here. The
    # password may be hashed as per the LocalcopyWinSMBPasswordFormat field.
    # @type [String] localcopy_win_smbpassword
    attr_accessor :localcopy_win_smbpassword

    # One of the PASSWORD_FORMAT_ constants. It controls the hash format of the LocalcopyWinSMBPassword
    # field.
    # @type [Number] localcopy_win_smbpassword_format
    attr_accessor :localcopy_win_smbpassword_format

    # @type [Comet::SwiftDestinationLocation] swift
    attr_accessor :swift

    # @type [Comet::B2DestinationLocation] b2
    attr_accessor :b2

    # This field is available in Comet 23.6.9 and later.
    # @type [Comet::WebDavDestinationLocation] web_dav
    attr_accessor :web_dav

    # @type [Comet::StorjDestinationLocation] storj
    attr_accessor :storj

    # @type [Comet::SMBDestinationLocation] smb
    attr_accessor :smb

    # A list of underlying destinations, that will be combined and presented as one.
    # @type [Array<Comet::DestinationLocation>] span_targets
    attr_accessor :span_targets

    # If true, this Spanned destination will use a consistent hashing scheme
    # to immediately find specific files on exactly one of the target destinations.
    # In the Static Slots mode, the span targets cannot be moved or merged, and
    # the files must always remain in their original location.
    #
    # If false, the Spanned destination system will search all targets to find
    # the requested file. This is slightly slower, but allows you to freely merge,
    # split, and reorder the underlying destination locations.
    #
    # The default option is false.
    # @type [Boolean] span_use_static_slots
    attr_accessor :span_use_static_slots

    # @type [String] tag
    attr_accessor :tag

    # One of the ENCRYPTIONMETHOD_ constants
    # @type [Number] encryption_key_encryption_method
    attr_accessor :encryption_key_encryption_method

    # @type [String] encrypted_encryption_key
    attr_accessor :encrypted_encryption_key

    # Unix timestamp in seconds. If zero, the Storage Vault has not yet been initialized for the first
    # time.
    # @type [Number] repo_init_timestamp
    attr_accessor :repo_init_timestamp

    # Storage Vault quota
    # @type [Boolean] storage_limit_enabled
    attr_accessor :storage_limit_enabled

    # Storage Vault quota
    # @type [Number] storage_limit_bytes
    attr_accessor :storage_limit_bytes

    # @type [Comet::DestinationStatistics] statistics
    attr_accessor :statistics

    # Configure the retention policy for this Storage Vault. The rules will be applied to any snapshot
    # inside this Storage Vault, unless that snapshot belongs to a Protected Item source that has an
    # overriding retention policy.
    # @type [Comet::RetentionPolicy] default_retention
    attr_accessor :default_retention

    # The "Prevent users from viewing the actual storage type" option
    # @type [Boolean] rebrand_storage
    attr_accessor :rebrand_storage

    # If not empty, an error occured during a retention pass. Describes the error.
    # @type [String] retention_error
    attr_accessor :retention_error

    # @type [Array<String>] associated_devices
    attr_accessor :associated_devices

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @description = ''
      @create_time = 0
      @modify_time = 0
      @pre_exec = []
      @thaw_exec = []
      @post_exec = []
      @destination_type = 0
      @comet_server = ''
      @comet_bucket = ''
      @comet_bucket_key = ''
      @s3server = ''
      @s3access_key = ''
      @s3secret_key = ''
      @s3bucket_name = ''
      @s3subdir = ''
      @s3custom_region = ''
      @s3object_lock_mode = 0
      @s3object_lock_days = 0
      @sftpserver = ''
      @sftpusername = ''
      @sftpremote_path = ''
      @sftpauth_mode = 0
      @sftppassword = ''
      @sftpprivate_key = ''
      @sftpcustom_auth__known_hosts_file = ''
      @ftpserver = ''
      @ftpusername = ''
      @ftppassword = ''
      @ftpcustom_base_directory = ''
      @ftpsmode = 0
      @ftpport = 0
      @ftpmax_connections = 0
      @azbaccount_name = ''
      @azbaccount_key = ''
      @azbcontainer = ''
      @azbrealm = ''
      @azbprefix = ''
      @localcopy_path = ''
      @localcopy_win_smbusername = ''
      @localcopy_win_smbpassword = ''
      @localcopy_win_smbpassword_format = 0
      @swift = Comet::SwiftDestinationLocation.new
      @b2 = Comet::B2DestinationLocation.new
      @web_dav = Comet::WebDavDestinationLocation.new
      @storj = Comet::StorjDestinationLocation.new
      @smb = Comet::SMBDestinationLocation.new
      @span_targets = []
      @tag = ''
      @encryption_key_encryption_method = 0
      @encrypted_encryption_key = ''
      @repo_init_timestamp = 0
      @storage_limit_bytes = 0
      @statistics = Comet::DestinationStatistics.new
      @default_retention = Comet::RetentionPolicy.new
      @retention_error = ''
      @associated_devices = []
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
        when 'Description'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @description = v
        when 'CreateTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @create_time = v
        when 'ModifyTime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @modify_time = v
        when 'PreExec'
          if v.nil?
            @pre_exec = []
          else
            @pre_exec = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @pre_exec[i1] = v1
            end
          end
        when 'ThawExec'
          if v.nil?
            @thaw_exec = []
          else
            @thaw_exec = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @thaw_exec[i1] = v1
            end
          end
        when 'PostExec'
          if v.nil?
            @post_exec = []
          else
            @post_exec = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @post_exec[i1] = v1
            end
          end
        when 'DestinationType'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @destination_type = v
        when 'CometServer'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @comet_server = v
        when 'CometBucket'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @comet_bucket = v
        when 'CometBucketKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @comet_bucket_key = v
        when 'S3Server'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @s3server = v
        when 'S3UsesTLS'
          @s3uses_tls = v
        when 'S3AccessKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @s3access_key = v
        when 'S3SecretKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @s3secret_key = v
        when 'S3BucketName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @s3bucket_name = v
        when 'S3Subdir'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @s3subdir = v
        when 'S3CustomRegion'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @s3custom_region = v
        when 'S3UsesV2Signing'
          @s3uses_v2signing = v
        when 'S3RemoveDeleted'
          @s3remove_deleted = v
        when 'S3ObjectLockMode'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @s3object_lock_mode = v
        when 'S3ObjectLockDays'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @s3object_lock_days = v
        when 'SFTPServer'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @sftpserver = v
        when 'SFTPUsername'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @sftpusername = v
        when 'SFTPRemotePath'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @sftpremote_path = v
        when 'SFTPAuthMode'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @sftpauth_mode = v
        when 'SFTPPassword'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @sftppassword = v
        when 'SFTPPrivateKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @sftpprivate_key = v
        when 'SFTPCustomAuth_UseKnownHostsFile'
          @sftpcustom_auth__use_known_hosts_file = v
        when 'SFTPCustomAuth_KnownHostsFile'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @sftpcustom_auth__known_hosts_file = v
        when 'FTPServer'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @ftpserver = v
        when 'FTPUsername'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @ftpusername = v
        when 'FTPPassword'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @ftppassword = v
        when 'FTPBaseUseHomeDirectory'
          @ftpbase_use_home_directory = v
        when 'FTPCustomBaseDirectory'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @ftpcustom_base_directory = v
        when 'FTPSMode'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @ftpsmode = v
        when 'FTPPort'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @ftpport = v
        when 'FTPMaxConnections'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @ftpmax_connections = v
        when 'FTPAcceptInvalidSSL'
          @ftpaccept_invalid_ssl = v
        when 'AZBAccountName'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @azbaccount_name = v
        when 'AZBAccountKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @azbaccount_key = v
        when 'AZBContainer'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @azbcontainer = v
        when 'AZBRealm'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @azbrealm = v
        when 'AZBPrefix'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @azbprefix = v
        when 'LocalcopyPath'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @localcopy_path = v
        when 'LocalcopyWinSMBUsername'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @localcopy_win_smbusername = v
        when 'LocalcopyWinSMBPassword'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @localcopy_win_smbpassword = v
        when 'LocalcopyWinSMBPasswordFormat'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @localcopy_win_smbpassword_format = v
        when 'Swift'
          @swift = Comet::SwiftDestinationLocation.new
          @swift.from_hash(v)
        when 'B2'
          @b2 = Comet::B2DestinationLocation.new
          @b2.from_hash(v)
        when 'WebDav'
          @web_dav = Comet::WebDavDestinationLocation.new
          @web_dav.from_hash(v)
        when 'Storj'
          @storj = Comet::StorjDestinationLocation.new
          @storj.from_hash(v)
        when 'SMB'
          @smb = Comet::SMBDestinationLocation.new
          @smb.from_hash(v)
        when 'SpanTargets'
          if v.nil?
            @span_targets = []
          else
            @span_targets = Array.new(v.length)
            v.each_with_index do |v1, i1|
              @span_targets[i1] = Comet::DestinationLocation.new
              @span_targets[i1].from_hash(v1)
            end
          end
        when 'SpanUseStaticSlots'
          @span_use_static_slots = v
        when 'Tag'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @tag = v
        when 'EncryptionKeyEncryptionMethod'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @encryption_key_encryption_method = v
        when 'EncryptedEncryptionKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @encrypted_encryption_key = v
        when 'RepoInitTimestamp'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @repo_init_timestamp = v
        when 'StorageLimitEnabled'
          @storage_limit_enabled = v
        when 'StorageLimitBytes'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @storage_limit_bytes = v
        when 'Statistics'
          @statistics = Comet::DestinationStatistics.new
          @statistics.from_hash(v)
        when 'DefaultRetention'
          @default_retention = Comet::RetentionPolicy.new
          @default_retention.from_hash(v)
        when 'RebrandStorage'
          @rebrand_storage = v
        when 'RetentionError'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @retention_error = v
        when 'AssociatedDevices'
          if v.nil?
            @associated_devices = []
          else
            @associated_devices = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @associated_devices[i1] = v1
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
      ret['Description'] = @description
      ret['CreateTime'] = @create_time
      ret['ModifyTime'] = @modify_time
      ret['PreExec'] = @pre_exec
      ret['ThawExec'] = @thaw_exec
      ret['PostExec'] = @post_exec
      ret['DestinationType'] = @destination_type
      ret['CometServer'] = @comet_server
      ret['CometBucket'] = @comet_bucket
      ret['CometBucketKey'] = @comet_bucket_key
      ret['S3Server'] = @s3server
      ret['S3UsesTLS'] = @s3uses_tls
      ret['S3AccessKey'] = @s3access_key
      ret['S3SecretKey'] = @s3secret_key
      ret['S3BucketName'] = @s3bucket_name
      ret['S3Subdir'] = @s3subdir
      ret['S3CustomRegion'] = @s3custom_region
      ret['S3UsesV2Signing'] = @s3uses_v2signing
      ret['S3RemoveDeleted'] = @s3remove_deleted
      ret['S3ObjectLockMode'] = @s3object_lock_mode
      ret['S3ObjectLockDays'] = @s3object_lock_days
      ret['SFTPServer'] = @sftpserver
      ret['SFTPUsername'] = @sftpusername
      ret['SFTPRemotePath'] = @sftpremote_path
      ret['SFTPAuthMode'] = @sftpauth_mode
      ret['SFTPPassword'] = @sftppassword
      ret['SFTPPrivateKey'] = @sftpprivate_key
      ret['SFTPCustomAuth_UseKnownHostsFile'] = @sftpcustom_auth__use_known_hosts_file
      ret['SFTPCustomAuth_KnownHostsFile'] = @sftpcustom_auth__known_hosts_file
      ret['FTPServer'] = @ftpserver
      ret['FTPUsername'] = @ftpusername
      ret['FTPPassword'] = @ftppassword
      ret['FTPBaseUseHomeDirectory'] = @ftpbase_use_home_directory
      ret['FTPCustomBaseDirectory'] = @ftpcustom_base_directory
      ret['FTPSMode'] = @ftpsmode
      ret['FTPPort'] = @ftpport
      ret['FTPMaxConnections'] = @ftpmax_connections
      ret['FTPAcceptInvalidSSL'] = @ftpaccept_invalid_ssl
      ret['AZBAccountName'] = @azbaccount_name
      ret['AZBAccountKey'] = @azbaccount_key
      ret['AZBContainer'] = @azbcontainer
      ret['AZBRealm'] = @azbrealm
      ret['AZBPrefix'] = @azbprefix
      ret['LocalcopyPath'] = @localcopy_path
      ret['LocalcopyWinSMBUsername'] = @localcopy_win_smbusername
      ret['LocalcopyWinSMBPassword'] = @localcopy_win_smbpassword
      ret['LocalcopyWinSMBPasswordFormat'] = @localcopy_win_smbpassword_format
      ret['Swift'] = @swift
      ret['B2'] = @b2
      ret['WebDav'] = @web_dav
      ret['Storj'] = @storj
      ret['SMB'] = @smb
      ret['SpanTargets'] = @span_targets
      ret['SpanUseStaticSlots'] = @span_use_static_slots
      ret['Tag'] = @tag
      ret['EncryptionKeyEncryptionMethod'] = @encryption_key_encryption_method
      ret['EncryptedEncryptionKey'] = @encrypted_encryption_key
      ret['RepoInitTimestamp'] = @repo_init_timestamp
      ret['StorageLimitEnabled'] = @storage_limit_enabled
      ret['StorageLimitBytes'] = @storage_limit_bytes
      unless @statistics.nil?
        ret['Statistics'] = @statistics
      end
      ret['DefaultRetention'] = @default_retention
      ret['RebrandStorage'] = @rebrand_storage
      ret['RetentionError'] = @retention_error
      ret['AssociatedDevices'] = @associated_devices
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
