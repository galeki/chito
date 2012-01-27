class ChangeSkinToTheme < ActiveRecord::Migration
  def up
    rename_column :users, :skin, :theme
  end

  def down
    rename_column :users, :theme, :skin 
  end
end
