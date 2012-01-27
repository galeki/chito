class AddDefaultTagsContext < ActiveRecord::Migration
  def up
    change_column :taggings, :context, :string, :default => 'tags'
  end

  def down
    change_column :taggings, :context, :string
  end
end
