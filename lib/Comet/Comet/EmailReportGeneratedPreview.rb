require 'json'

module Comet
  
  class EmailReportGeneratedPreview
    
    # @type [Number] status
    attr_accessor :status
    
    # @type [String] message
    attr_accessor :message
    
    # @type [String] email_subject
    attr_accessor :email_subject
    
    # @type [String] email_body_html
    attr_accessor :email_body_html
    
    # @type [String] email_body_plaintext
    attr_accessor :email_body_plaintext
    
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
        when "Status"
          @status = v
        when "Message"
          raise TypeError 'expected string' unless v.is_a? String
          @message = v
        when "EmailSubject"
          raise TypeError 'expected string' unless v.is_a? String
          @email_subject = v
        when "EmailBodyHTML"
          raise TypeError 'expected string' unless v.is_a? String
          @email_body_html = v
        when "EmailBodyPlaintext"
          raise TypeError 'expected string' unless v.is_a? String
          @email_body_plaintext = v
        else
          @unknown_json_fields[k] = v
        end
      end
    end
    
    # @return [Hash] The complete object as a Ruby hash
    def to_hash()
      ret = {}
      ret["Status"] = @status
      ret["Message"] = @message
      ret["EmailSubject"] = @email_subject
      ret["EmailBodyHTML"] = @email_body_html
      ret["EmailBodyPlaintext"] = @email_body_plaintext
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