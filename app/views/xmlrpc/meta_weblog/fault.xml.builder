xml.instruct! :xml, :version => "1.0", :encoding=>"UTF-8"
xml.methodResponse do
    xml.fault do
        xml.value do
            xml.struct do
                xml.member do
                    xml.name "faultCode"
                    xml.value do
                        xml.i4 @fault_code.to_i
                    end
                end
                xml.member do
                    xml.name "faultString"
                    xml.value do
                        xml.string (@fault_string + " [from #{@method_name}]")
                    end
                end
            end
        end
    end
end
