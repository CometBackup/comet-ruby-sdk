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

  # BackupRuleEventTriggers is a typed class wrapper around the underlying Comet Server API data structure.
  class BackupRuleEventTriggers

    # @type [Boolean] on_pcboot
    attr_accessor :on_pcboot

    # @type [Boolean] on_pcboot_if_last_job_missed
    attr_accessor :on_pcboot_if_last_job_missed

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @unknown_json_fields = {}
    end

    # @param [String] json_string The complete object in JSON format
    def from_json(json_string)
      raise TypeError "'json_string' expected String, got #{json_string.class}" unless json_string.is_a? String


      from_hash(JSON.parse(json_string))
    end

    # @param [Hash] obj The complete object as a Ruby hash
    def from_hash(obj)
      raise TypeError "'obj' expected Hash, got #{obj.class}" unless obj.is_a? Hash


      obj.each do |k, v|
        case k
        when 'OnPCBoot'
          @on_pcboot = v
        when 'OnPCBootIfLastJobMissed'
          @on_pcboot_if_last_job_missed = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      unless @on_pcboot.nil?
        ret['OnPCBoot'] = @on_pcboot
      end
      unless @on_pcboot_if_last_job_missed.nil?
        ret['OnPCBootIfLastJobMissed'] = @on_pcboot_if_last_job_missed
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
