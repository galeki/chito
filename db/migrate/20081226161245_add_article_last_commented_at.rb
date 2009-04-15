class AddArticleLastCommentedAt < ActiveRecord::Migration
  def self.up
    add_column :articles, :last_commented_at, :datetime
  end

  def self.down
    remove_column :articles, :last_commented_at
  end
end
