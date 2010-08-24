xml.instruct! :xml, :version => "1.0", :encoding=>"UTF-8"
xml.methodResponse do
  xml.params do
    xml.param do
      xml.value do
        xml.struct do
           xml.member do
              xml.name "url"
              xml.value do
                xml.string @new_file_url
              end
           end
        end
      end
    end
  end
end
