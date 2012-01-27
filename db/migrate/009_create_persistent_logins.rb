class CreatePersistentLogins < ActiveRecord::Migration
  def up
    create_table :persistent_logins do |t|
	t.column :uid,		:text
	t.column :user_id,	:integer
	t.column :created_on,	:datetime 
    end
  end

  def down
    drop_table :persistent_logins
  end
end
