class AddSiteIndexMode < ActiveRecord::Migration
  def self.up
    add_column :sites, :index_mode, :string
  end

  def self.down
    remove_column :sites, :index_mode
  end
end
