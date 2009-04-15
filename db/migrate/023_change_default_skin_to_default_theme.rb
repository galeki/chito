class ChangeDefaultSkinToDefaultTheme < ActiveRecord::Migration
  def self.up
    rename_column :sites, :default_skin, :default_theme
  end

  def self.down
    rename_column :sites, :default_theme, :default_skin
  end
end
