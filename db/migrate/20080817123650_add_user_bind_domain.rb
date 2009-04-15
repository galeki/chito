class AddUserBindDomain < ActiveRecord::Migration
  def self.up
    add_column :users, :bind_domain, :string  
  end

  def self.down
    remove_column :users, :bind_domain    
  end
end
