class AddSiteIndexTheme < ActiveRecord::Migration
  def up
    add_column :sites, :index_theme, :string
  end

  def down
    remove_column :sites, :index_theme
  end
end
