xml.instruct! :xml, :version => "1.0", :encoding=>"UTF-8"
xml.methodResponse do
  xml.params do
    xml.param do
      xml.value do
              xml.struct do
                  xml.member do
                    xml.name "categories"
                    xml.value do
                        xml.array do
                            xml.data do
                                xml.value @post.category.name
                            end
                        end
                    end
                  end
                  xml.member do
                    xml.name "dateCreated"
                    xml.value do
                        xml.tag!('dateTime.iso8601', @post.created_at.to_s(:iso8601))
                    end
                  end
                  xml.member do
                    xml.name "userid"
                    xml.value do
                        xml.string @post.user_id
                    end
                  end
                  xml.member do
                    xml.name "description"
                    xml.value do
                        xml.string @post.content
                    end
                  end
                  xml.member do
                    xml.name "link"
                    xml.value do
                        xml.string post_url(@post)
                    end
                  end
                  xml.member do
                    xml.name "postid"
                    xml.value do
                        xml.i4 @post.id
                    end
                  end
                  xml.member do
                    xml.name "title"
                    xml.value do
                        xml.string @post.title
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
