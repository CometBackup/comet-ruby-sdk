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

  # MongoDBConnection is a typed class wrapper around the underlying Comet Server API data structure.
  class MongoDBConnection

    # @type [String] server
    attr_accessor :server

    # @type [Number] port
    attr_accessor :port

    # @type [String] username
    attr_accessor :username

    # @type [String] password
    attr_accessor :password

    # @type [String] authentication_db
    attr_accessor :authentication_db

    # @type [String] mongo_shell_path
    attr_accessor :mongo_shell_path

    # @type [String] mongodump_path
    attr_accessor :mongodump_path

    # @type [String] read_preference
    attr_accessor :read_preference

    # @type [Boolean] use_replica
    attr_accessor :use_replica

    # @type [String] replica_name
    attr_accessor :replica_name

    # @type [Array<String>] replica_members
    attr_accessor :replica_members

    # @type [Boolean] use_ssl
    attr_accessor :use_ssl

    # @type [String] client_sslpempath
    attr_accessor :client_sslpempath

    # @type [String] server_sslpempath
    attr_accessor :server_sslpempath

    # @type [String] sslclient_key_password
    attr_accessor :sslclient_key_password

    # @type [Boolean] allow_invalid_certificate
    attr_accessor :allow_invalid_certificate

    # @type [Boolean] allow_invalid_hostname
    attr_accessor :allow_invalid_hostname

    # @type [Boolean] use_ssh
    attr_accessor :use_ssh

    # @type [Comet::SSHConnection] sshconnection
    attr_accessor :sshconnection

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      @replica_members = []
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
        when 'Server'
          raise TypeError 'expected string' unless v.is_a? String

          @server = v
        when 'Port'
          @port = v
        when 'Username'
          raise TypeError 'expected string' unless v.is_a? String

          @username = v
        when 'Password'
          raise TypeError 'expected string' unless v.is_a? String

          @password = v
        when 'AuthenticationDB'
          raise TypeError 'expected string' unless v.is_a? String

          @authentication_db = v
        when 'MongoShellPath'
          raise TypeError 'expected string' unless v.is_a? String

          @mongo_shell_path = v
        when 'MongodumpPath'
          raise TypeError 'expected string' unless v.is_a? String

          @mongodump_path = v
        when 'ReadPreference'
          raise TypeError 'expected string' unless v.is_a? String

          @read_preference = v
        when 'UseReplica'
          @use_replica = v
        when 'ReplicaName'
          raise TypeError 'expected string' unless v.is_a? String

          @replica_name = v
        when 'ReplicaMembers'
          if v.nil?
            @replica_members = []
          else
            @replica_members = Array.new(v.length)
            v.each_with_index do |v1, i1|
              raise TypeError 'expected string' unless v1.is_a? String

              @replica_members[i1] = v1
            end
          end
        when 'UseSSL'
          @use_ssl = v
        when 'ClientSSLPEMPath'
          raise TypeError 'expected string' unless v.is_a? String

          @client_sslpempath = v
        when 'ServerSSLPEMPath'
          raise TypeError 'expected string' unless v.is_a? String

          @server_sslpempath = v
        when 'SSLClientKeyPassword'
          raise TypeError 'expected string' unless v.is_a? String

          @sslclient_key_password = v
        when 'AllowInvalidCertificate'
          @allow_invalid_certificate = v
        when 'AllowInvalidHostname'
          @allow_invalid_hostname = v
        when 'UseSSH'
          @use_ssh = v
        when 'SSHConnection'
          @sshconnection = Comet::SSHConnection.new
          @sshconnection.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Server'] = @server
      ret['Port'] = @port
      ret['Username'] = @username
      ret['Password'] = @password
      ret['AuthenticationDB'] = @authentication_db
      ret['MongoShellPath'] = @mongo_shell_path
      ret['MongodumpPath'] = @mongodump_path
      ret['ReadPreference'] = @read_preference
      ret['UseReplica'] = @use_replica
      ret['ReplicaName'] = @replica_name
      ret['ReplicaMembers'] = @replica_members
      ret['UseSSL'] = @use_ssl
      ret['ClientSSLPEMPath'] = @client_sslpempath
      ret['ServerSSLPEMPath'] = @server_sslpempath
      ret['SSLClientKeyPassword'] = @sslclient_key_password
      ret['AllowInvalidCertificate'] = @allow_invalid_certificate
      ret['AllowInvalidHostname'] = @allow_invalid_hostname
      ret['UseSSH'] = @use_ssh
      unless @sshconnection.nil?
        ret['SSHConnection'] = @sshconnection
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
