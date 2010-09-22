class Group < ActiveRecord::Base
    has_flags [:api_enable, true], [:column => 'bit_opt']
    has_many :users
    validates_uniqueness_of :name
    validates_presence_of :name
    
    def self.admin
        Group.find_by_name("Admin")
    end

    def self.default
        Group.find_by_name("Default")
    end

    def self.init
        unless Group.admin && Group.default
            Group.create(:name => "Admin", :space => 1024, :file_size_limit => 100)
            Group.create(:name => "Default", :space => 50, :file_size_limit => 3)
        end
    end

    def space
        super.blank? ? 0 : super
    end

    def file_size_limit
        super.blank? ? 0 : super
    end

    def deletable?
        self.name != "Admin" and self.name != "Default"
    end

end
