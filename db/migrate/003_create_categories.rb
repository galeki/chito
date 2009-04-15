class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
	t.column :name,		:string
	t.column :info,		:text
	t.column :created_at,	:datetime
	t.column :position,	:integer, :default => 0
	t.column :bit_opt,	:integer, :default => 0	
	t.column :user_id,	:integer
    end
  end

  def self.down
    drop_table :categories
  end
end
