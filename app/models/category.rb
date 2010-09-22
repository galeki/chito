class Category < ActiveRecord::Base
    belongs_to :user
    has_many :posts,
             :class_name => "Article",
             :conditions => ["articles.bit_opt = 0"],
             :order => 'articles.created_at DESC'
    validates_presence_of :name 
    validates_uniqueness_of :permalink

    def info
        super.blank? ? "- No Info -" : super
    end

    def permalink
        super.blank? ? "- No Permalink -" : super
    end

end
