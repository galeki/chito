class AddArticleIndexId < ActiveRecord::Migration
  def up
    add_column :articles, :index_id, :integer
  end

  def down
    remove_column :articles, :index_id
  end
end
