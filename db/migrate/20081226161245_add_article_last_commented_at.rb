class AddArticleLastCommentedAt < ActiveRecord::Migration
  def up
    add_column :articles, :last_commented_at, :datetime
  end

  def down
    remove_column :articles, :last_commented_at
  end
end
