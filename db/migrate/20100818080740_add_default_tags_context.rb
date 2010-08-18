class AddDefaultTagsContext < ActiveRecord::Migration
  def self.up
    change_column :taggings, :context, :string, :default => 'tags'
  end

  def self.down
    change_column :taggings, :context, :string
  end
end
