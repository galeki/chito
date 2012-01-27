class AddSiteFooter < ActiveRecord::Migration
  def up
    add_column :sites, :footer, :string 
  end

  def down
    remove_column :sites, :footer 
  end
end
