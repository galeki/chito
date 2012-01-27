class AddUserLastLoginedInAt < ActiveRecord::Migration
  def up
    add_column :users, :last_logined_in_at, :datetime
  end

  def down
    remove_column :users, :last_logined_in_at
  end
end
