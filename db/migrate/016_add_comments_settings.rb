class AddCommentsSettings < ActiveRecord::Migration
  def up
    add_column :comments, :settings, :text
  end

  def down
    remove_column :comments, :settings
  end
end
