xml.instruct! :xml, :version => "1.0", :encoding=>"UTF-8"
xml.methodResponse do
  xml.params do
    xml.param do
      xml.value do
        xml.array do
          xml.data do
            @pages.each do |p|
              xml.value do
                xml.struct do
                  xml.member do
                    xml.name "page_id"
                    xml.value do
                        xml.int p.id
                    end
                  end
                  xml.member do
                    xml.name "title"
                    xml.value do
                        xml.string p.title
                    end
                  end
                  xml.member do
                    xml.name "description"
                    xml.value do
                        xml.string p.content
                    end
                  end
                  xml.member do
                    xml.name "dateCreated"
                    xml.value do
                        xml.tag!('dateTime.iso8601', p.created_at.to_s(:iso8601))
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
