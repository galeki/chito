class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
	t.column :writer,	:string
	t.column :homepage,	:string
	t.column :email,	:string
	t.column :content,	:text
	t.column :created_at,	:datetime
	t.column :user_id,	:integer
	t.column :article_id,	:integer
	t.column :bit_opt,	:integer, :default => 0
    end
  end

  def self.down
    drop_table :comments
  end
end
