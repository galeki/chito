class AddCategoryPermalink < ActiveRecord::Migration
  def up
    add_column :categories, :permalink, :string
    add_index :categories, :permalink
  end

  def down
    remove_index :categories, :permalink
    remove_column :categories, :permalink, :string
  end
end
