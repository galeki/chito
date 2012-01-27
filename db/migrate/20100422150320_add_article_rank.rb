class AddArticleRank < ActiveRecord::Migration
  def up
    add_column :articles, :rank, :integer, :default => 0
  end

  def down
    remove_column :article, :rank
  end
end
