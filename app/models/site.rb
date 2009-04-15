class Site < ActiveRecord::Base
    has_flags [:registerable], [:column => 'bit_opt']

    @@site = nil

    def self.instance
	@@site ||= Site.find(:first, :order => "created_at")
	@@site
    end

    def mutli_users?
	self.user_mode == "m"
    end

    def single_user?
	self.user_mode == "s"
    end
    
    def get_user(request)
	if self.single_user? or request.subdomains.first.blank? or (request.domain == self.domain && request.subdomains.first == "www")
	    user = User.find_by_name(self.default_user)
	elsif request.domain == self.domain
	    user = User.find_by_name(request.subdomains.first)	
	else
	    user = User.find_by_bind_domain(request.host)
	end
	user
    end
end
