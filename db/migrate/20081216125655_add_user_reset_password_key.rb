class AddUserResetPasswordKey < ActiveRecord::Migration
  def self.up
    add_column :users, :reset_password_key, :string
    add_column :users, :reset_password_key_expires_at, :datetime    
  end

  def self.down
    remove_column :users, :reset_password_key
    remove_column :users, :reset_password_key_expires_at    
  end
end
