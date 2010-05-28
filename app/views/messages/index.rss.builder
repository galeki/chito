xml.instruct! :xml, :version => "1.0"
xml.rss "version" => "2.0",
	"xmlns:dc" => "http://purl.org/dc/element/1.1/",
	"xmlns:content" => "http://purl.org/rss/1.0/modules/content/" do
    xml.channel do
	xml.title "#{h(@user.title)} - #{t(:message_0, :scope => [:txt, :view, :messages, :index, :builder])}"
	xml.generator 'Chito'

	@messages.each do |message|
	    xml.item do
		xml.title h(message.writer)
		#xml.link post_url(comment.article, :anchor => "comment#{comment.id}")
		xml.pubDate message.created_at.to_s(:rfc822)
		#xml.guid post_url(comment.article, :anchor => "comment#{comment.id}")
		xml.tag! 'content:encoded' do
		    xml.cdata! sanitize(message.content)
		end
		xml.author h(message.writer)
	    end
	end
    end
end
