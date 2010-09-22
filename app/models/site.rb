class Site < ActiveRecord::Base
    has_flags [:registerable], [:column => 'bit_opt']
    has_settings :nil_value => ['', '0']
    attr_accessor :index

    @@site = nil

    def self.instance
        @@site ||= Site.first
        @@site
    end

    def mutli_users?
        self.user_mode == "m"
    end

    def single_user?
        self.user_mode == "s"
    end

    def no_subdomain?(request)
        if request.domain == self.domain
            return true if request.subdomains.first.blank?
            return true if request.subdomains.first == "www"
        end
        return false
    end

    def get_index(request)
        @index = Index.find_by_bind_domain(request.host) || Index.find_by_bind_domain("www." + request.host)
        @index
    end
    
    def get_user(request)
        if self.single_user? #or no_subdomain?(request) 
            user = User.find_by_name(self.default_user)
        elsif request.domain == self.domain
            user = User.find_by_name(request.subdomains.join("."))      
        else
            user = User.find_by_bind_domain(request.host) || User.find_by_bind_domain("www." + request.host)
        end
        user || User.find_by_name(self.default_user)
    end

end
