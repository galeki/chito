class AddArticleIndexId < ActiveRecord::Migration
  def self.up
    add_column :articles, :index_id, :integer
  end

  def self.down
    remove_column :articles, :index_id
  end
end
