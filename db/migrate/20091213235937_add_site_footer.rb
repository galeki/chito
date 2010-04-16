class AddSiteFooter < ActiveRecord::Migration
  def self.up
    add_column :sites, :footer, :string 
  end

  def self.down
    remove_column :sites, :footer 
  end
end
