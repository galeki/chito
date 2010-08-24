xml.instruct! :xml, :version => "1.0", :encoding=>"UTF-8"
xml.methodResponse do
  xml.params do
    xml.param do
      xml.value do
        xml.array do
          xml.data do
            @recent_posts.each do |p|
            xml.value do
              xml.struct do
                  xml.member do
                    xml.name "categories"
                    xml.value do
                        xml.array do
                            xml.data do
                                xml.value p.category.name
                            end
                        end
                    end
                  end
                  xml.member do
                    xml.name "dateCreated"
                    xml.value do
                        xml.tag!('dateTime.iso8601', p.created_at.to_s(:iso8601))
                    end
                  end
                  xml.member do
                    xml.name "userid"
                    xml.value do
                        xml.string p.user_id
                    end
                  end
                  xml.member do
                    xml.name "description"
                    xml.value do
                        xml.string p.content
                    end
                  end
                  xml.member do
                    xml.name "link"
                    xml.value do
                        xml.string post_url(p)
                    end
                  end
                  xml.member do
                    xml.name "postid"
                    xml.value do
                        xml.i4 p.id
                    end
                  end
                  xml.member do
                    xml.name "title"
                    xml.value do
                        xml.string p.title
                    end
                  end
                  xml.member do
                    xml.name "publish"
                    xml.value do
                        xml.boolean 1
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
