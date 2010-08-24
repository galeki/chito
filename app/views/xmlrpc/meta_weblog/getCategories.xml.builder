xml.instruct! :xml, :version => "1.0", :encoding=>"UTF-8"
xml.methodResponse do
  xml.params do
    xml.param do
      xml.value do
        xml.array do
          xml.data do
            @categories.each do |c|
            xml.value do
              xml.struct do
                  xml.member do
                    xml.name "categoryId"
                    xml.value do
                        xml.int c.id
                    end
                  end
                  xml.member do
                    xml.name "categoryName"
                    xml.value do
                        xml.string c.name
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
