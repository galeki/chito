xml.instruct! :xml, :version => "1.0", :encoding=>"UTF-8"
xml.methodResponse do
  xml.params do
    xml.param do
      xml.value do
        xml.array do
          xml.data do
            xml.value do
              xml.struct do
                  xml.member do
                    xml.name "url"
                    xml.value root_url
                  end
                  xml.member do
                    xml.name "blogid"
                    xml.value @user.name
                  end
                  xml.member do
                    xml.name "blogName"
                    xml.value @user.title
                  end
              end
            end
          end
        end
      end
    end
  end
end
