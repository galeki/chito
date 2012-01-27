class AddSiteIndexMode < ActiveRecord::Migration
  def up
    add_column :sites, :index_mode, :string
  end

  def down
    remove_column :sites, :index_mode
  end
end
