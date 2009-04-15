class DeletePersistloginTable < ActiveRecord::Migration
  def self.up
    drop_table :persistent_logins
  end

  def self.down
    create_table :persistent_logins do |t|
	t.column :uid,		:text
	t.column :user_id,	:integer
	t.column :created_on,	:datetime 
    end
  end
end
