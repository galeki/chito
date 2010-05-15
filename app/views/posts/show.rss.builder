xml.instruct! :xml, :version => "1.0"
xml.rss "version" => "2.0",
	"xmlns:dc" => "http://purl.org/dc/element/1.1/",
	"xmlns:content" => "http://purl.org/rss/1.0/modules/content/",
	"xmlns:wfw" => "http://wellformedweb.org/CommentAPI/" do
    xml.channel do
	xml.title "#{h(@post.title)} - #{t(:comments, :scope => [:txt, :view, :posts, :show, :rss])}"
	xml.link post_url(@post, :format => :rss)
	xml.generator 'Chito'

	@comments.each do |comment|
	    xml.item do
		xml.title h(comment.writer)
		xml.link post_url(comment.article, :anchor => "comment#{comment.id}")
		xml.pubDate comment.created_at.to_s(:rfc822)
		xml.guid post_url(comment.article, :anchor => "comment#{comment.id}")
		xml.tag! 'content:encoded' do
		    xml.cdata! white_list(comment.content)
		end
		xml.author h(comment.writer)
	    end
	end
    end
end
