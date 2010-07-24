class AddUserLastLoginedInAt < ActiveRecord::Migration
  def self.up
    add_column :users, :last_logined_in_at, :datetime
  end

  def self.down
    remove_column :users, :last_logined_in_at
  end
end
