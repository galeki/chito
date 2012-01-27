class AddArticlePublishedAt < ActiveRecord::Migration
  def up
      add_column :articles, :published_at, :datetime
      Article.all.each do |a|
          a.published_at = a.created_at
          a.save
      end
  end

  def down
      remove_column :articles, :published_at
  end
end
