# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class BackupJobProgress
    
    # @type [Number] counter
    attr_accessor :counter
    
    # @type [Number] sent_time
    attr_accessor :sent_time
    
    # @type [Number] recieved_time
    attr_accessor :recieved_time
    
    # @type [Number] bytes_done
    attr_accessor :bytes_done
    
    # @type [Number] items_done
    attr_accessor :items_done
    
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
        when "Counter"
          @counter = v
        when "SentTime"
          @sent_time = v
        when "RecievedTime"
          @recieved_time = v
        when "BytesDone"
          @bytes_done = v
        when "ItemsDone"
          @items_done = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["Counter"] = @counter
      ret["SentTime"] = @sent_time
      ret["RecievedTime"] = @recieved_time
      ret["BytesDone"] = @bytes_done
      ret["ItemsDone"] = @items_done
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