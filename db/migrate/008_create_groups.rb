class CreateGroups < ActiveRecord::Migration
  def up
    create_table :groups do |t|
	t.column :name,		    :string
	t.column :space,	    :integer, :default => 0
	t.column :file_size_limit,  :integer, :default => 0
	t.column :package_data,	    :text
	t.column :bit_opt,	    :integer, :default => 0
    end
  end

  def down
    drop_table :groups
  end
end
