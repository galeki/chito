class AddSiteSettings < ActiveRecord::Migration
  def self.up
    add_column :sites, :settings, :text
  end

  def self.down
    remove_column :sites, :settings
  end
end
