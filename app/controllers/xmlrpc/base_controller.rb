require 'xmlrpc/parser'
class Xmlrpc::BaseController < ApplicationController
    class XMLRPCFaultError < RuntimeError; end
    rescue_from XMLRPCFaultError, :with => :fault
    rescue_from NoMethodError, :with => :fault
    before_filter :get_params, :rename_method
    @@method_alias = {}

    def index
        call_method
        render @method_name
    end

    def fault
        @fault_code ||= 2041
        @fault_string ||= "Unexcept Error"
        render "fault"
    end

    def self.method_alias(hash)
        @@method_alias = hash
    end
    
    private
    def get_params
        data = XMLRPC::XMLParser::REXMLStreamParser.new.parseMethodCall(request.raw_post)
        @method_name = data[0].split('.').last
        @method_params = data[1]
    end 

    def call_method
        if @method_name
           __send__(@method_name.to_sym)
        else
            raise_fault(2041, "Invalid method name")
        end
    end

    def rename_method
        if @@method_alias[@method_name.to_s]
            @method_name = @@method_alias[@method_name.to_s]
        end
    end

    def raise_fault(code, string)
        @fault_code = code
        @fault_string = string
        raise XMLRPCFaultError
    end
end

