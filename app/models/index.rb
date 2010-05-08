class Index < ActiveRecord::Base
    acts_as_settings :nil_value => ['', '0']
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

end
