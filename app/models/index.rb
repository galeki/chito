class Index < ActiveRecord::Base
    has_settings :nil_value => ['', '0']
    has_and_belongs_to_many :users, :select => "distinct users.*"
    has_many :posts,
	     :class_name => "Article",
	     :conditions => ["articles.bit_opt = 0"],
	     :order => 'articles.created_at DESC'

    validates_uniqueness_of :title
    validates_presence_of :title

    def bind_domain
        super.blank? ? "- Not Specify -" : super
    end
    
    def info
        super.blank? ? "- Not Specify -" : super
    end

    def public_path
        File.join RAILS_ROOT, "public/index", self.id.to_s
    end

    def avatar=(file)
	Dir.mkdir(self.public_path) unless File.exists?(self.public_path)  
	File.open(File.join(self.public_path, "avatar.png"), "wb") do |f| 
	    f.write(file.read)
	end
    end

    def avatar_url
        "/index/#{self.id}/avatar.png"
    end
end
