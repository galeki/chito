xml.instruct! :xml, :version => "1.0", :encoding=>"UTF-8"
xml.rss "version" => "2.0",
	"xmlns:wfw" => "http://wellformedweb.org/CommentAPI/" do
    xml.channel do
	xml.title @site.title
	xml.link root_url :subdomain => "www"
	xml.generator "Chito #{VER}"

	@posts.each do |post|
	    xml.item do
		xml.title {xml.cdata! post.title}
		xml.link formatted_post_url(post, :html) 
		    xml.description do
			xml.cdata! rss_content(post.brief)
		    end
		xml.tag! 'wfw:commentRss', formatted_post_url(post, :rss)
		xml.pubDate post.created_at.to_s(:rfc822)
		xml.guid post_url(post)
	    end
	end
    end
end
