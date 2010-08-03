# encoding: utf-8
xml.instruct! :xml, :version => "1.0", :encoding=>"UTF-8"
xml.rss "version" => "2.0",
	"xmlns:wfw" => "http://wellformedweb.org/CommentAPI/" do
    xml.channel do
	xml.title {xml.cdata! @index.title }
	xml.link "http://" + @index.bind_domain 
	xml.generator "Chito #{VER}"
	xml.description {xml.cdata! @index.info } 

	@posts.each do |post|
	    xml.item do
		xml.title {xml.cdata! post.title}
		xml.link post_url(post, :subdomain => post.user.name, :format => :html) 
		xml.description do
		    xml.cdata! post.brief
		end
		xml.tag! 'wfw:commentRss', post_url(post, :format => :rss)
		xml.pubDate post.created_at.to_s(:rfc822)
		xml.guid post_url(post, :html, :subdomain => post.user.name, :format => :html)
	    end
	end
    end
end
