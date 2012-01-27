class ChangeDefaultSkinToDefaultTheme < ActiveRecord::Migration
  def up
    rename_column :sites, :default_skin, :default_theme
  end

  def down
    rename_column :sites, :default_theme, :default_skin
  end
end
