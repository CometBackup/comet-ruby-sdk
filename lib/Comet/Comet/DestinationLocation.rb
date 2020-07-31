require 'json'

module Comet
  
  class DestinationLocation
    
    # @type [Number] destination_type
    attr_accessor :destination_type
    
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
    
    # @type [Boolean] s3uses_v2signing
    attr_accessor :s3uses_v2signing
    
    # @type [String] sftpserver
    attr_accessor :sftpserver
    
    # @type [String] sftpusername
    attr_accessor :sftpusername
    
    # @type [String] sftpremote_path
    attr_accessor :sftpremote_path
    
    # @type [Number] sftpauth_mode
    attr_accessor :sftpauth_mode
    
    # @type [String] sftppassword
    attr_accessor :sftppassword
    
    # @type [String] sftpprivate_key
    attr_accessor :sftpprivate_key
    
    # @type [Boolean] sftpcustom_auth__use_known_hosts_file
    attr_accessor :sftpcustom_auth__use_known_hosts_file
    
    # @type [String] sftpcustom_auth__known_hosts_file
    attr_accessor :sftpcustom_auth__known_hosts_file
    
    # @type [String] ftpserver
    attr_accessor :ftpserver
    
    # @type [String] ftpusername
    attr_accessor :ftpusername
    
    # @type [String] ftppassword
    attr_accessor :ftppassword
    
    # @type [Boolean] ftpbase_use_home_directory
    attr_accessor :ftpbase_use_home_directory
    
    # @type [String] ftpcustom_base_directory
    attr_accessor :ftpcustom_base_directory
    
    # @type [Number] ftpsmode
    attr_accessor :ftpsmode
    
    # @type [Number] ftpport
    attr_accessor :ftpport
    
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
    
    # @type [String] azbrealm
    attr_accessor :azbrealm
    
    # @type [String] azbprefix
    attr_accessor :azbprefix
    
    # @type [String] localcopy_path
    attr_accessor :localcopy_path
    
    # @type [String] localcopy_win_smbusername
    attr_accessor :localcopy_win_smbusername
    
    # @type [String] localcopy_win_smbpassword
    attr_accessor :localcopy_win_smbpassword
    
    # @type [Number] localcopy_win_smbpassword_format
    attr_accessor :localcopy_win_smbpassword_format
    
    # @type [Comet::SwiftDestinationLocation] swift
    attr_accessor :swift
    
    # @type [Comet::B2DestinationLocation] b2
    attr_accessor :b2
    
    # @type [Array<Comet::DestinationLocation>] span_targets
    attr_accessor :span_targets
    
    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields
    
    def initialize()
      @unknown_json_fields = {} # empty hashmap
    end
    
    # @param [String] json_string The complete object in JSON format
    def from_json(json_string)
      from_hash(JSON.parse(json_string))
    end
    
    # @param [Hash] obj The complete object as a Ruby hash
    def from_hash(obj)
      obj.each do |k, v|
        case k
        when "DestinationType"
          @destination_type = v
        when "CometServer"
          raise TypeError 'expected string' unless v.is_a? String
          @comet_server = v
        when "CometBucket"
          raise TypeError 'expected string' unless v.is_a? String
          @comet_bucket = v
        when "CometBucketKey"
          raise TypeError 'expected string' unless v.is_a? String
          @comet_bucket_key = v
        when "S3Server"
          raise TypeError 'expected string' unless v.is_a? String
          @s3server = v
        when "S3UsesTLS"
          @s3uses_tls = v
        when "S3AccessKey"
          raise TypeError 'expected string' unless v.is_a? String
          @s3access_key = v
        when "S3SecretKey"
          raise TypeError 'expected string' unless v.is_a? String
          @s3secret_key = v
        when "S3BucketName"
          raise TypeError 'expected string' unless v.is_a? String
          @s3bucket_name = v
        when "S3Subdir"
          raise TypeError 'expected string' unless v.is_a? String
          @s3subdir = v
        when "S3UsesV2Signing"
          @s3uses_v2signing = v
        when "SFTPServer"
          raise TypeError 'expected string' unless v.is_a? String
          @sftpserver = v
        when "SFTPUsername"
          raise TypeError 'expected string' unless v.is_a? String
          @sftpusername = v
        when "SFTPRemotePath"
          raise TypeError 'expected string' unless v.is_a? String
          @sftpremote_path = v
        when "SFTPAuthMode"
          @sftpauth_mode = v
        when "SFTPPassword"
          raise TypeError 'expected string' unless v.is_a? String
          @sftppassword = v
        when "SFTPPrivateKey"
          raise TypeError 'expected string' unless v.is_a? String
          @sftpprivate_key = v
        when "SFTPCustomAuth_UseKnownHostsFile"
          @sftpcustom_auth__use_known_hosts_file = v
        when "SFTPCustomAuth_KnownHostsFile"
          raise TypeError 'expected string' unless v.is_a? String
          @sftpcustom_auth__known_hosts_file = v
        when "FTPServer"
          raise TypeError 'expected string' unless v.is_a? String
          @ftpserver = v
        when "FTPUsername"
          raise TypeError 'expected string' unless v.is_a? String
          @ftpusername = v
        when "FTPPassword"
          raise TypeError 'expected string' unless v.is_a? String
          @ftppassword = v
        when "FTPBaseUseHomeDirectory"
          @ftpbase_use_home_directory = v
        when "FTPCustomBaseDirectory"
          raise TypeError 'expected string' unless v.is_a? String
          @ftpcustom_base_directory = v
        when "FTPSMode"
          @ftpsmode = v
        when "FTPPort"
          @ftpport = v
        when "FTPMaxConnections"
          @ftpmax_connections = v
        when "FTPAcceptInvalidSSL"
          @ftpaccept_invalid_ssl = v
        when "AZBAccountName"
          raise TypeError 'expected string' unless v.is_a? String
          @azbaccount_name = v
        when "AZBAccountKey"
          raise TypeError 'expected string' unless v.is_a? String
          @azbaccount_key = v
        when "AZBContainer"
          raise TypeError 'expected string' unless v.is_a? String
          @azbcontainer = v
        when "AZBRealm"
          raise TypeError 'expected string' unless v.is_a? String
          @azbrealm = v
        when "AZBPrefix"
          raise TypeError 'expected string' unless v.is_a? String
          @azbprefix = v
        when "LocalcopyPath"
          raise TypeError 'expected string' unless v.is_a? String
          @localcopy_path = v
        when "LocalcopyWinSMBUsername"
          raise TypeError 'expected string' unless v.is_a? String
          @localcopy_win_smbusername = v
        when "LocalcopyWinSMBPassword"
          raise TypeError 'expected string' unless v.is_a? String
          @localcopy_win_smbpassword = v
        when "LocalcopyWinSMBPasswordFormat"
          @localcopy_win_smbpassword_format = v
        when "Swift"
          @swift = Comet::SwiftDestinationLocation.new
          @swift.from_hash(v)
        when "B2"
          @b2 = Comet::B2DestinationLocation.new
          @b2.from_hash(v)
        when "SpanTargets"
          @span_targets = Array.new(v.length)
          v.each_with_index do |v, i|
            @span_targets[i] = Comet::DestinationLocation.new
            @span_targets[i].from_hash(v)
          end
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["DestinationType"] = @destination_type
      ret["CometServer"] = @comet_server
      ret["CometBucket"] = @comet_bucket
      ret["CometBucketKey"] = @comet_bucket_key
      ret["S3Server"] = @s3server
      ret["S3UsesTLS"] = @s3uses_tls
      ret["S3AccessKey"] = @s3access_key
      ret["S3SecretKey"] = @s3secret_key
      ret["S3BucketName"] = @s3bucket_name
      ret["S3Subdir"] = @s3subdir
      ret["S3UsesV2Signing"] = @s3uses_v2signing
      ret["SFTPServer"] = @sftpserver
      ret["SFTPUsername"] = @sftpusername
      ret["SFTPRemotePath"] = @sftpremote_path
      ret["SFTPAuthMode"] = @sftpauth_mode
      ret["SFTPPassword"] = @sftppassword
      ret["SFTPPrivateKey"] = @sftpprivate_key
      ret["SFTPCustomAuth_UseKnownHostsFile"] = @sftpcustom_auth__use_known_hosts_file
      ret["SFTPCustomAuth_KnownHostsFile"] = @sftpcustom_auth__known_hosts_file
      ret["FTPServer"] = @ftpserver
      ret["FTPUsername"] = @ftpusername
      ret["FTPPassword"] = @ftppassword
      ret["FTPBaseUseHomeDirectory"] = @ftpbase_use_home_directory
      ret["FTPCustomBaseDirectory"] = @ftpcustom_base_directory
      ret["FTPSMode"] = @ftpsmode
      ret["FTPPort"] = @ftpport
      ret["FTPMaxConnections"] = @ftpmax_connections
      ret["FTPAcceptInvalidSSL"] = @ftpaccept_invalid_ssl
      ret["AZBAccountName"] = @azbaccount_name
      ret["AZBAccountKey"] = @azbaccount_key
      ret["AZBContainer"] = @azbcontainer
      ret["AZBRealm"] = @azbrealm
      ret["AZBPrefix"] = @azbprefix
      ret["LocalcopyPath"] = @localcopy_path
      ret["LocalcopyWinSMBUsername"] = @localcopy_win_smbusername
      ret["LocalcopyWinSMBPassword"] = @localcopy_win_smbpassword
      ret["LocalcopyWinSMBPasswordFormat"] = @localcopy_win_smbpassword_format
      ret["Swift"] = @swift
      ret["B2"] = @b2
      ret["SpanTargets"] = @span_targets
      @unknown_json_fields.each do |k, v|
        ret[k] = v
      end
      ret
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_h()
      to_hash()
    end
    
    # @return [String] The complete object as a JSON string
    def to_json(*a)
      to_hash().to_json *a
    end
    
  end
  
end # module