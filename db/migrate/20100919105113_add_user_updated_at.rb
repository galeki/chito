class AddUserUpdatedAt < ActiveRecord::Migration
  def up
    add_column :users, :updated_at, :datetime
  end

  def down
    remove_column :users, :updated_at
  end
end
