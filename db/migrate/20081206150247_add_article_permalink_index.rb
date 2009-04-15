class AddArticlePermalinkIndex < ActiveRecord::Migration
  def self.up
    add_index :articles, :permalink  
  end

  def self.down
    remove_index :articles, :permalink  
  end
end
