class Feedback < ActiveRecord::Base
	has_flags [:pass, :is_message, :is_trackback], [:column => 'bit_opt']	
	has_settings :nil_value => ['', '0']
	belongs_to :article
	belongs_to :user
	validates_presence_of :writer
	validates_presence_of :content
	validates_length_of :content, :maximum => 10000

    def request=(request)
	self.ip = request.remote_ip
	self.user_agent = request.env['HTTP_USER_AGENT']
	self.referer = request.env['HTTP_REFERER']
    end

    def prepare(params, request, session, cookies)
	self.request = request
	self.pass = true
	if session[:user_name]
	    user = User.find(session[:user_id])
	    if user
	    	self.email = user.email
	    	self.twitter = user.twitter 	    
	    end	
	    self.writer = session[:user_nick] 
	    self.user_name = session[:user_name]
	    self.user_post = true
	    self.post_by = session[:user_id]
	end
	self.twitter = self.twitter.split('/').last unless self.twitter.blank?
	cookies[:comment_writer] = {:value => self.writer, :expires => 365.days.from_now, :domain => request.domain}
	cookies[:comment_homepage] = {:value => self.homepage, :expires => 365.days.from_now, :domain => request.domain}
	cookies[:comment_email] = {:value => self.email, :expires => 365.days.from_now, :domain => request.domain}
	cookies[:comment_twitter] = {:value => self.twitter, :expires => 365.days.from_now, :domain => request.domain}
    end

    def prepare_trackback(request, params)
	self.request = request
	self.is_trackback = true
	self.pass =true
	self.article_id = params[:post_id]
	self.homepage = params[:url]
	self.writer = params[:title] || params[:blog_name]
	self.content = params[:excerpt] && helpers.truncate(helpers.strip_tags(params[:excerpt]), :length => 200)
    end

    def avatar_url
	if self.user_name
	    avatar = Dir[File.join(User::BASE_DIR, self.user_name, "config", "{avatar_small.png,head_small.jpg}")].sort.first
	    return "/user_files/#{self.user_name}/config/#{File.basename(avatar)}" if avatar
	end
	return "/user_files/avatar_small.png"
    end
end

class CommentFilterBlock < RuntimeError; end
