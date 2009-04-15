class CreatePersistentLogins < ActiveRecord::Migration
  def self.up
    create_table :persistent_logins do |t|
	t.column :uid,		:text
	t.column :user_id,	:integer
	t.column :created_on,	:datetime 
    end
  end

  def self.down
    drop_table :persistent_logins
  end
end
