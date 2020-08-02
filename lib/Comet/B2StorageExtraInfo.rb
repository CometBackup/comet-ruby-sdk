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

  # B2StorageExtraInfo is a typed class wrapper around the underlying Comet Server API data structure.
  class B2StorageExtraInfo

    # @type [Hash{Number => Comet::B2TransactionTotals}] total_transactions_in_time_interval
    attr_accessor :total_transactions_in_time_interval

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      @total_transactions_in_time_interval = {}
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
        when 'TotalTransactionsInTimeInterval'
          @total_transactions_in_time_interval = {}
          if v.nil?
            @total_transactions_in_time_interval = {}
          else
            v.each do |k1, v1|
              @total_transactions_in_time_interval[k1] = Comet::B2TransactionTotals.new
              @total_transactions_in_time_interval[k1].from_hash(v1)
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
      ret['TotalTransactionsInTimeInterval'] = @total_transactions_in_time_interval
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
