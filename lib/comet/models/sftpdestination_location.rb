# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # SFTPDestinationLocation is a typed class wrapper around the underlying Comet Server API data structure.
  class SFTPDestinationLocation

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

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @sftpserver = ''
      @sftpusername = ''
      @sftpremote_path = ''
      @sftpauth_mode = 0
      @sftppassword = ''
      @sftpprivate_key = ''
      @sftpcustom_auth__known_hosts_file = ''
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
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['SFTPServer'] = @sftpserver
      ret['SFTPUsername'] = @sftpusername
      ret['SFTPRemotePath'] = @sftpremote_path
      ret['SFTPAuthMode'] = @sftpauth_mode
      ret['SFTPPassword'] = @sftppassword
      ret['SFTPPrivateKey'] = @sftpprivate_key
      ret['SFTPCustomAuth_UseKnownHostsFile'] = @sftpcustom_auth__use_known_hosts_file
      ret['SFTPCustomAuth_KnownHostsFile'] = @sftpcustom_auth__known_hosts_file
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
