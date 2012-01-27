class AddUsersCacheSpace < ActiveRecord::Migration
  def up
    add_column :users, :cache_space, :integer, :default => -1
  end

  def down
    remove_column :users, :cache_space
  end
end
