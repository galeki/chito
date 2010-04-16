class AddUsersCacheSpace < ActiveRecord::Migration
  def self.up
    add_column :users, :cache_space, :integer, :default => -1
  end

  def self.down
    remove_column :users, :cache_space
  end
end
