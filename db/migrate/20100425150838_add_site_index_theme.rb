class AddSiteIndexTheme < ActiveRecord::Migration
  def self.up
    add_column :sites, :index_theme, :string
  end

  def self.down
    remove_column :sites, :index_theme
  end
end
