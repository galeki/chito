class AddCommentUsername < ActiveRecord::Migration
  def self.up
    add_column :comments, :user_name, :string
  end

  def self.down
    remove_column :comments, :user_name
  end
end
