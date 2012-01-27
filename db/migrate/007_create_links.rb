class CreateLinks < ActiveRecord::Migration
  def up
    create_table :links do |t|
	t.column :title,	:string
	t.column :url,		:string
	t.column :info,		:text
	t.column :created_at,	:datetime
	t.column :user_id,	:integer
	t.column :position,	:integer, :default => 0
	t.column :bit_opt,	:integer, :default => 0
    end
  end

  def down
    drop_table :links
  end
end
