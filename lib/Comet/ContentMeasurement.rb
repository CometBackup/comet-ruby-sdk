# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class ContentMeasurement
    
    # @type [Number] measure_started
    attr_accessor :measure_started
    
    # @type [Number] measure_completed
    attr_accessor :measure_completed
    
    # @type [Array<Comet::ContentMeasurementComponent>] components
    attr_accessor :components
    
    # @type [Hash] Hidden storage to preserve future properties for non-destructive roundtrip operations
    attr_accessor :unknown_json_fields
    
    def initialize()
      @components = []
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
        when "MeasureStarted"
          @measure_started = v
        when "MeasureCompleted"
          @measure_completed = v
        when "Components"
          if v != nil
            @components = Array.new(v.length)
            v.each_with_index do |v, i|
              @components[i] = Comet::ContentMeasurementComponent.new
              @components[i].from_hash(v)
            end
          else
            @components = []
          end
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["MeasureStarted"] = @measure_started
      ret["MeasureCompleted"] = @measure_completed
      ret["Components"] = @components
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