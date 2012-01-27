class AddSiteSettings < ActiveRecord::Migration
  def up
    add_column :sites, :settings, :text
  end

  def down
    remove_column :sites, :settings
  end
end
