class FixArticlesReadCountDefaultZero < ActiveRecord::Migration
  def self.up
    change_column :articles, :read_count, :integer, :default => 0
  end

  def self.down
    change_column :articles, :read_count, :integer
  end
end
