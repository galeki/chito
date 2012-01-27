class CreateSites < ActiveRecord::Migration
  def up
    create_table :sites do |t|
	t.column :title,	    :string
	t.column :url,		    :string
	t.column :domain,	    :string
	t.column :default_user,	    :string
	t.column :default_skin,	    :string
	t.column :user_mode,	    :string
	t.column :created_at,	    :datetime
	t.column :default_group,    :integer
	t.column :bit_opt,	    :integer, :default => 0
    end
  end

  def own
    drop_table :sites
  end
end
