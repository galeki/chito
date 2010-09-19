class AddUserUpdatedAt < ActiveRecord::Migration
  def self.up
    add_column :users, :updated_at, :datetime
  end

  def self.down
    remove_column :users, :updated_at
  end
end
