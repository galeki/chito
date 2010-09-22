require 'digest/md5'
module BlogHelperPlugin
    
    def rewriter_of_guest_avatar
        image_tag gravatar_url(@comment.email || "chito"), :alt => ""
    end

    private

    def gravatar_url(email)
        url = "http://www.gravatar.com/avatar/"
        hash = Digest::MD5.hexdigest(email)
        params = "?s=60"
        url + hash + params
    end
end
