class AddUserNameIndex < ActiveRecord::Migration
  def up
    add_index :users, :name
  end

  def down
    remove_index :users, :name
  end
end
