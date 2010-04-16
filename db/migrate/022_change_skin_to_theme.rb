class ChangeSkinToTheme < ActiveRecord::Migration
  def self.up
    rename_column :users, :skin, :theme
  end

  def self.down
    rename_column :users, :theme, :skin 
  end
end
