class AddCommentUsername < ActiveRecord::Migration
  def up
    add_column :comments, :user_name, :string
  end

  def down
    remove_column :comments, :user_name
  end
end
