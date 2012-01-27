class AddArticlePermalinkIndex < ActiveRecord::Migration
  def up
    add_index :articles, :permalink  
  end

  def down
    remove_index :articles, :permalink  
  end
end
