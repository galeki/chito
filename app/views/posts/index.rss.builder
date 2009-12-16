xml.instruct! :xml, :version => "1.0", :encoding=>"UTF-8"
xml.rss "version" => "2.0",
	"xmlns:wfw" => "http://wellformedweb.org/CommentAPI/" do
    xml.channel do
	xml.title {xml.cdata! @user.title }
	if request.domain == @site.domain
	    xml.link root_url :subdomain => @user.name
	else
	    xml.link root_url
	end
	xml.generator "Chito #{VER}"
	xml.description {xml.cdata! @user.info } 

	@posts.each do |post|
	    xml.item do
		xml.title {xml.cdata! post.title}
		xml.link formatted_post_url(post, :html) 
		if @user.rss_type == 'full'
		    xml.description do
			xml.cdata! rss_content(post.content)
		    end
		else
		    xml.description do
			xml.cdata! rss_content(post.brief)
		    end
		end
		(xml.category {xml.cdata! post.category.name}) if post.category
		xml.tag! 'wfw:commentRss', formatted_post_url(post, :rss)
		xml.pubDate post.created_at.to_s(:rfc822)
		xml.guid post_url(post)
	    end
	end
    end
end
