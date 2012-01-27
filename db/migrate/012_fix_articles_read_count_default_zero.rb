class FixArticlesReadCountDefaultZero < ActiveRecord::Migration
  def up
    change_column :articles, :read_count, :integer, :default => 0
  end

  def down
    change_column :articles, :read_count, :integer
  end
end
