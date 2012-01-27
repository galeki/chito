class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
	t.column :name,		    :string,	:null => false
	t.column :nick,		    :string
	t.column :email,	    :string
	t.column :title,	    :string
	t.column :info,		    :string
	t.column :hashed_password,  :string
	t.column :skin,		    :string
	t.column :package_data,	    :text
	t.column :created_at,	    :datetime
	t.column :bit_opt,	    :integer,	:default => 0
	t.column :blog_read,	    :integer,	:default => 0
	t.column :group_id,	    :integer
    end
  end

  def down
    drop_table :users
  end
end
