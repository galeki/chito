class AddCategoryPermalink < ActiveRecord::Migration
  def self.up
    add_column :categories, :permalink, :string
    add_index :categories, :permalink
  end

  def self.down
    remove_index :categories, :permalink
    remove_column :categories, :permalink, :string
  end
end
