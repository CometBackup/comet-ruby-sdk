# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # SourceConfig is a typed class wrapper around the underlying Comet Server API data structure.
  class SourceConfig

    # One of the ENGINE_BUILTIN_ constants
    # @type [String] engine
    attr_accessor :engine

    # @type [String] description
    attr_accessor :description

    # @type [String] owner_device
    attr_accessor :owner_device

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

    # Configuration for the selected Protected Item type. Each "Engine" supports
    # different configuration options for the EngineProps values.
    #
    # For engine1/file, Comet understands the following EngineProp keys:
    #
    # - Any key starting with INCLUDE: A path that is included
    # - Any key starting with EXCLUDE: An exclusion (glob format)
    # - Any key starting with REXCLUDE: An exclusion (regular expression format)
    # - Any key starting with PINCLUDE: A SourceIncludePattern type encoded in JSON format, describing
    # an advanced inclusion in glob format
    # - Any key starting with RINCLUDE: A SourceIncludePattern type encoded in JSON format, describing
    # an advanced inclusion in regular expression format
    # - Any key starting with SMBAUTH: A set of Windows network share credentials in WinSMBAuth JSON
    # format
    # - USE_WIN_VSS: If present, the 'Take filesystem snapshot' checkbox is checked
    # - CONFIRM_EFS: If present, the 'Dismiss EFS warning' checkbox is checked
    # - RESCAN_UNCHANGED: If present, the 'Rescan unchanged files' checkbox is checked
    # - EXTRA_ATTRIBUTES: If present, the 'Back up extra system permissions and attributes' checkbox is
    # checked
    #
    # For engine1/mssql, Comet understands the following EngineProp keys:
    #
    # - ALL_DATABASES: If present, include all databases with specified exclusions. If not present, only
    # back up the specified inclusions
    # - Any key starting with DATABASE- : A database that is included. Only valid if ALL_DATABASES is
    # not present.
    # - Any key starting with EXCEPT-DATABASE- : A database that is excluded. Only valid if
    # ALL_DATABASES is present.
    # - INSTANCE: The Microsoft SQL Server instance name
    # - USERNAME: The username to connect to Microsoft SQL Server
    # - PASSWORD: The password to connect to Microsoft SQL Server
    # - AUTHMODE: Either "windows" or "native" (corresponding to the declared MSSQL_AUTH_WINDOWS and
    # MSSQL_AUTH_NATIVE constant values). If not present, use native authentication if the USERNAME
    # and/or PASSWORD fields are filled in, use windows authentication if they are blank
    # - METHOD: Either "OLEDB_NATIVE" or "OLEDB_32" (corresponding to the declared
    # MSSQL_METHOD_OLEDB_NATIVE and MSSQL_METHOD_OLEDB_32 constant values). If not present, defaults to
    # Native
    # - DIFFBASE: If present, take a "Full (base image)" backup job. Otherwise, take a "Full (copy
    # only)" backup job.
    # - DIFFERENTIAL: If present, take a "Differential increment" backup job. Otherwise, take a "Full
    # (copy only)" backup job.
    # - LOGTRUNC: If present, take a "Log (truncating)" backup job. Otherwise, take a "Full (copy only)"
    # backup job.
    # - LOGNOTRUNC: If present, take a "Log (no truncation)" backup job. Otherwise, take a "Full (copy
    # only)" backup job.
    #
    # @type [Hash{String => String}] engine_props
    attr_accessor :engine_props

    # If set, this SourceConfig was added from a Policy with the specified ID.
    # This field is available in Comet 23.6.0 and later.
    # @type [String] policy_source_id
    attr_accessor :policy_source_id

    # For a Policy-defined SourceConfig, this field controls whether the Protected Item will stay linked
    # with the policy.
    # This field is available in Comet 23.6.0 and later.
    # @type [Boolean] existing_user_update
    attr_accessor :existing_user_update

    # By default, backup jobs from this Protected Item will be subject
    # to the overall retention policy for the Storage Vault. You can override the policy
    # for specific Storage Vaults by putting their destination ID as a key here.
    # @type [Hash{String => Comet::RetentionPolicy}] override_destination_retention
    attr_accessor :override_destination_retention

    # @type [Comet::SourceStatistics] statistics
    attr_accessor :statistics

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @engine = ''
      @description = ''
      @owner_device = ''
      @create_time = 0
      @modify_time = 0
      @pre_exec = []
      @thaw_exec = []
      @post_exec = []
      @engine_props = {}
      @policy_source_id = ''
      @override_destination_retention = {}
      @statistics = Comet::SourceStatistics.new
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
        when 'Engine'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @engine = v
        when 'Description'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @description = v
        when 'OwnerDevice'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @owner_device = v
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
        when 'EngineProps'
          @engine_props = {}
          if v.nil?
            @engine_props = {}
          else
            v.each do |k1, v1|
              raise TypeError, "'v1' expected String, got #{v1.class}" unless v1.is_a? String

              @engine_props[k1] = v1
            end
          end
        when 'PolicySourceID'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @policy_source_id = v
        when 'ExistingUserUpdate'
          @existing_user_update = v
        when 'OverrideDestinationRetention'
          @override_destination_retention = {}
          if v.nil?
            @override_destination_retention = {}
          else
            v.each do |k1, v1|
              @override_destination_retention[k1] = Comet::RetentionPolicy.new
              @override_destination_retention[k1].from_hash(v1)
            end
          end
        when 'Statistics'
          @statistics = Comet::SourceStatistics.new
          @statistics.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Engine'] = @engine
      ret['Description'] = @description
      ret['OwnerDevice'] = @owner_device
      ret['CreateTime'] = @create_time
      ret['ModifyTime'] = @modify_time
      ret['PreExec'] = @pre_exec
      ret['ThawExec'] = @thaw_exec
      ret['PostExec'] = @post_exec
      ret['EngineProps'] = @engine_props
      ret['PolicySourceID'] = @policy_source_id
      ret['ExistingUserUpdate'] = @existing_user_update
      unless @override_destination_retention.nil?
        ret['OverrideDestinationRetention'] = @override_destination_retention
      end
      unless @statistics.nil?
        ret['Statistics'] = @statistics
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
