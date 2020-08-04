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

  # ReplicatorStateAPIResponse is a typed class wrapper around the underlying Comet Server API data structure.
  class ReplicatorStateAPIResponse

    # @type [String] description
    attr_accessor :description

    # @type [String] remote_server_id
    attr_accessor :remote_server_id

    # @type [Number] display_class
    attr_accessor :display_class

    # @type [Number] active_workers
    attr_accessor :active_workers

    # @type [Number] total_workers
    attr_accessor :total_workers

    # @type [Number] state
    attr_accessor :state

    # @type [Number] items_queued
    attr_accessor :items_queued

    # @type [Number] bytes_queued
    attr_accessor :bytes_queued

    # @type [Number] last_worker_submit_time
    attr_accessor :last_worker_submit_time

    # @type [Number] current_time
    attr_accessor :current_time

    # @type [Number] items_replicated
    attr_accessor :items_replicated

    # @type [Number] bytes_replicated
    attr_accessor :bytes_replicated

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
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
        when 'Description'
          raise TypeError 'expected string' unless v.is_a? String

          @description = v
        when 'RemoteServerID'
          raise TypeError 'expected string' unless v.is_a? String

          @remote_server_id = v
        when 'DisplayClass'
          @display_class = v
        when 'ActiveWorkers'
          @active_workers = v
        when 'TotalWorkers'
          @total_workers = v
        when 'State'
          @state = v
        when 'ItemsQueued'
          @items_queued = v
        when 'BytesQueued'
          @bytes_queued = v
        when 'LastWorkerSubmitTime'
          @last_worker_submit_time = v
        when 'CurrentTime'
          @current_time = v
        when 'ItemsReplicated'
          @items_replicated = v
        when 'BytesReplicated'
          @bytes_replicated = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['Description'] = @description
      ret['RemoteServerID'] = @remote_server_id
      ret['DisplayClass'] = @display_class
      ret['ActiveWorkers'] = @active_workers
      ret['TotalWorkers'] = @total_workers
      ret['State'] = @state
      ret['ItemsQueued'] = @items_queued
      ret['BytesQueued'] = @bytes_queued
      ret['LastWorkerSubmitTime'] = @last_worker_submit_time
      ret['CurrentTime'] = @current_time
      ret['ItemsReplicated'] = @items_replicated
      ret['BytesReplicated'] = @bytes_replicated
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
