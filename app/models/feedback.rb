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
        cookies.permanent[:comment_writer] = {:value => self.writer, :domain => request.domain}
        cookies.permanent[:comment_homepage] = {:value => self.homepage, :domain => request.domain}
        cookies.permanent[:comment_email] = {:value => self.email, :domain => request.domain}
        cookies.permanent[:comment_twitter] = {:value => self.twitter, :domain => request.domain}
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

    def short_brief(n)
        str = self.writer + ":" + self.content
        str = helpers.strip_tags(str) if self.mode == 'html'
        str = helpers.truncate(str, :length => n)
        str
    end
end

class CommentFilterBlock < RuntimeError; end
