class RenameCommentsTable < ActiveRecord::Migration
  def self.up
    rename_table :comments, :feedbacks
  end

  def self.down
    rename_table :feedbacks, :comments 
  end
end
