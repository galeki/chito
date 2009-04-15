require 'net/http'
require 'uri'
class Article < ActiveRecord::Base
	acts_as_taggable
	acts_as_settings :nil_value => ['', '0']
	has_flags [:is_none, :is_draft, :is_page], [:column => 'bit_opt']
	belongs_to :user 
	has_many :comments, 
		 :class_name => 'Feedback',
		 :order => 'feedbacks.created_at', 
		 :conditions => ["feedbacks.bit_opt = 1"]
	has_many :trackbacks, 
		 :class_name => 'Feedback',
		 :order => 'feedbacks.created_at', 
		 :conditions => ["feedbacks.bit_opt = 5"]
	belongs_to :category
	include ArticlePlugin

    def title
	super.blank? ? t(:message_0, :scope => [:txt, :model, :article]) : super
    end

    def prepare(user, params)
	self.bit_opt_will_change!
	self.attributes = params[:article]
	self.user_id = user.id
	self.category = user.categories.find(params[:category] || :first)
    end

    def make_brief
      return unless self.auto_brief
      index = self.content.index('<!--more-->')
      if index
	s = content[0,index]
	self.has_more = true
	self.brief = close_html(s)
      else
	self.has_more = false
      end
    end

    def trackback_params
	{:title => self.title,
	 :excerpt => helpers.truncate(helpers.strip_tags(self.brief), :length => 200),
	 :blog_name => self.user.title}
    end

    def brief
	(self.auto_brief && !self.has_more) ? self.content : "<p>#{super}</p>"
    end

    def prev
        self.category.posts.find(:first, :conditions => ["created_at < ? and bit_opt = 0 ", self.created_at]) if self.category
    end

    def next
	self.category.posts.find(:first, :conditions => ["created_at > ? and bit_opt = 0 ", self.created_at], :order => 'id') if self.category
    end

    def to_xml(options={})
	only = {:only => [:title, :created_at, :content, :writer]}
	super only.merge(options)
    end

    private

    def close_html(html)
	stream = html.scan(/<\s*[\/]*[^>^\/]+>/).map {|x| x[/<\s*([^>^\s]*)[^>]*>/, 1]}
	stack = []
	stream.each do |x|
	    if x =~ /^\//
		stack.pop if x[1..-1] == stack.last
	    else
		stack.push x
	    end
	end
	stack.reverse.each {|x| html << "</#{x}>\n"}
	html
    end 

end
