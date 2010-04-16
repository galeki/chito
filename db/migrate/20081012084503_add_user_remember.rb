class AddUserRemember < ActiveRecord::Migration
  def self.up
    add_column :users, :remember_key, :string      
    add_index :users, :remember_key      
    add_column :users, :remember_key_expires_at, :datetime      
  end

  def self.down
    remove_index :users, :remember_key    
    remove_column :users, :remember_key    
    remove_column :users, :remember_key_expires_at
  end
end
