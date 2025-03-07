# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'json'

module Comet

  # StoredObject is a typed class wrapper around the underlying Comet Server API data structure.
  class StoredObject

    # The name of the stored object. It is unique within this directory tree.
    # @type [String] name
    attr_accessor :name

    # Unix timestamp in seconds
    # @type [Number] modify_time
    attr_accessor :modify_time

    # One of the STOREDOBJECTTYPE_... constant values
    # @type [String] type
    attr_accessor :type

    # If this StoredObject represents a directory, this value can be used to recursively select the
    # directory contents.
    # @type [String] subtree
    attr_accessor :subtree

    # Bytes
    # @type [Number] size
    attr_accessor :size

    # @type [String] display_name
    attr_accessor :display_name

    # @type [String] item_class
    attr_accessor :item_class

    # @type [String] from
    attr_accessor :from

    # @type [String] to
    attr_accessor :to

    # @type [Number] received_date_time
    attr_accessor :received_date_time

    # @type [Boolean] has_attachments
    attr_accessor :has_attachments

    # Unix timestamp in seconds
    # @type [Number] start_time
    attr_accessor :start_time

    # Unix timestamp in seconds
    # @type [Number] end_time
    attr_accessor :end_time

    # @type [Boolean] recursive_count_known
    attr_accessor :recursive_count_known

    # @type [Number] recursive_files
    attr_accessor :recursive_files

    # @type [Number] recursive_bytes
    attr_accessor :recursive_bytes

    # @type [Number] recursive_folders
    attr_accessor :recursive_folders

    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields

    def initialize
      clear
    end

    def clear
      @name = ''
      @modify_time = 0
      @type = ''
      @subtree = ''
      @size = 0
      @display_name = ''
      @item_class = ''
      @from = ''
      @to = ''
      @received_date_time = 0
      @start_time = 0
      @end_time = 0
      @recursive_files = 0
      @recursive_bytes = 0
      @recursive_folders = 0
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
        when 'name'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @name = v
        when 'mtime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @modify_time = v
        when 'type'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @type = v
        when 'subtree'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @subtree = v
        when 'size'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @size = v
        when 'dname'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @display_name = v
        when 'itemClass'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @item_class = v
        when 'from'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @from = v
        when 'to'
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          @to = v
        when 'rtime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @received_date_time = v
        when 'has_attachments'
          @has_attachments = v
        when 'stime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @start_time = v
        when 'etime'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @end_time = v
        when 'r'
          @recursive_count_known = v
        when 'f'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @recursive_files = v
        when 'b'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @recursive_bytes = v
        when 'd'
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          @recursive_folders = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end

    # @return [Hash] The complete object as a Ruby hash
    def to_hash
      ret = {}
      ret['name'] = @name
      ret['mtime'] = @modify_time
      ret['type'] = @type
      ret['subtree'] = @subtree
      ret['size'] = @size
      unless @display_name.nil?
        ret['dname'] = @display_name
      end
      unless @item_class.nil?
        ret['itemClass'] = @item_class
      end
      unless @from.nil?
        ret['from'] = @from
      end
      unless @to.nil?
        ret['to'] = @to
      end
      unless @received_date_time.nil?
        ret['rtime'] = @received_date_time
      end
      unless @has_attachments.nil?
        ret['has_attachments'] = @has_attachments
      end
      unless @start_time.nil?
        ret['stime'] = @start_time
      end
      unless @end_time.nil?
        ret['etime'] = @end_time
      end
      unless @recursive_count_known.nil?
        ret['r'] = @recursive_count_known
      end
      unless @recursive_files.nil?
        ret['f'] = @recursive_files
      end
      unless @recursive_bytes.nil?
        ret['b'] = @recursive_bytes
      end
      unless @recursive_folders.nil?
        ret['d'] = @recursive_folders
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
