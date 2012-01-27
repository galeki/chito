class AddArticlePermalink < ActiveRecord::Migration
  def up
    add_column :articles, :permalink, :string
  end

  def down
    remove_column :articles, :permalink
  end
end
