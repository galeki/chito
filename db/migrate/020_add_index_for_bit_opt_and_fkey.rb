class AddIndexForBitOptAndFkey < ActiveRecord::Migration
  def self.up
    add_index :articles, :bit_opt
    add_index :articles, :user_id
    add_index :articles, :category_id

    add_index :categories, :bit_opt
    add_index :categories, :user_id
    
    add_index :comments, :bit_opt
    add_index :comments, :user_id
    add_index :comments, :article_id

    add_index :links, :bit_opt
    add_index :links, :user_id
    
    change_column :persistent_logins, :uid, :string, :null => false
    add_index :persistent_logins, :uid

    add_index :users, :bit_opt
    add_index :users, :group_id
  end

  def self.down
    remove_index :articles, :bit_opt
    remove_index :articles, :user_id
    remove_index :articles, :category_id

    remove_index :categories, :bit_opt
    remove_index :categories, :user_id
    
    remove_index :comments, :bit_opt
    remove_index :comments, :user_id
    remove_index :comments, :article_id

    remove_index :links, :bit_opt
    remove_index :links, :user_id

    remove_index :persistent_logins, :uid
    change_column :persistent_logins, :uid, :text

    remove_index :users, :bit_opt
    remove_index :users, :group_id
  end
end
