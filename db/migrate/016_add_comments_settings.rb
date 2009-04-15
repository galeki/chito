class AddCommentsSettings < ActiveRecord::Migration
  def self.up
    add_column :comments, :settings, :text
  end

  def self.down
    remove_column :comments, :settings
  end
end
