class AddArticleCreatedOn < ActiveRecord::Migration
  def up
    add_column :articles, :created_on, :datetime
  end

  def down
    remove_column :articles, :created_on, :datetime
  end
end
