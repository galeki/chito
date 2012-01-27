class RenameCommentsTable < ActiveRecord::Migration
  def up
    rename_table :comments, :feedbacks
  end

  def down
    rename_table :feedbacks, :comments 
  end
end
