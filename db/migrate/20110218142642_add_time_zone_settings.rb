class AddTimeZoneSettings < ActiveRecord::Migration
  def up
    add_column :sites, :default_time_zone, :string
    add_column :users, :time_zone, :string
  end

  def down
    remove_column :sites, :default_time_zone
    remove_column :users, :time_zone
  end
end
