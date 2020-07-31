# Copyright (c) 2020-2020 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
# 
# SPDX-License-Identifier: MIT

require 'json'

module Comet
  
  class EmailReportConfig
    
    # @type [Number] report_type
    attr_accessor :report_type
    
    # @type [Array<Comet::ScheduleConfig>] summary_frequency
    attr_accessor :summary_frequency
    
    # @type [Comet::SearchClause] filter
    attr_accessor :filter
    
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
        when "ReportType"
          @report_type = v
        when "SummaryFrequency"
          @summary_frequency = Array.new(v.length)
          v.each_with_index do |v, i|
            @summary_frequency[i] = Comet::ScheduleConfig.new
            @summary_frequency[i].from_hash(v)
          end
        when "Filter"
          @filter = Comet::SearchClause.new
          @filter.from_hash(v)
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["ReportType"] = @report_type
      ret["SummaryFrequency"] = @summary_frequency
      ret["Filter"] = @filter
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