class AddArticleRank < ActiveRecord::Migration
  def self.up
    add_column :articles, :rank, :integer, :default => 0
  end

  def self.down
    remove_column :article, :rank
  end
end
