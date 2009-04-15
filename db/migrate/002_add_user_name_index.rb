class AddUserNameIndex < ActiveRecord::Migration
  def self.up
    add_index :users, :name
  end

  def self.down
    remove_index :users, :name
  end
end
