# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # SSHConnection is a typed class wrapper around the underlying Comet Server API data structure.
  class SSHConnection

    # @type [String] sshserver
    attr_accessor :sshserver

    # @type [String] sshusername
    attr_accessor :sshusername

    # @type [Number] sshauth_mode
    attr_accessor :sshauth_mode

    # @type [String] sshpassword
    attr_accessor :sshpassword

    # @type [String] sshprivate_key
    attr_accessor :sshprivate_key

    # @type [Boolean] sshcustom_auth__use_known_hosts_file
    attr_accessor :sshcustom_auth__use_known_hosts_file

    # @type [String] sshcustom_auth__known_hosts_file
    attr_accessor :sshcustom_auth__known_hosts_file

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @sshserver = ''
      @sshusername = ''
      @sshauth_mode = 0
      @sshpassword = ''
      @sshprivate_key = ''
      @sshcustom_auth__known_hosts_file = ''
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
        when 'SSHServer'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @sshserver = v
        when 'SSHUsername'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @sshusername = v
        when 'SSHAuthMode'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @sshauth_mode = v
        when 'SSHPassword'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @sshpassword = v
        when 'SSHPrivateKey'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @sshprivate_key = v
        when 'SSHCustomAuth_UseKnownHostsFile'
          @sshcustom_auth__use_known_hosts_file = v
        when 'SSHCustomAuth_KnownHostsFile'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @sshcustom_auth__known_hosts_file = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['SSHServer'] = @sshserver
      ret['SSHUsername'] = @sshusername
      ret['SSHAuthMode'] = @sshauth_mode
      ret['SSHPassword'] = @sshpassword
      ret['SSHPrivateKey'] = @sshprivate_key
      ret['SSHCustomAuth_UseKnownHostsFile'] = @sshcustom_auth__use_known_hosts_file
      ret['SSHCustomAuth_KnownHostsFile'] = @sshcustom_auth__known_hosts_file
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
