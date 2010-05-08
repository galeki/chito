class CreateIndexModel < ActiveRecord::Migration
  def self.up
    create_table :indices do |t|
        t.column :title, :string
        t.column :theme, :string
        t.column :bind_domain, :string
        t.column :info, :text
        t.column :settings, :text
    end
    create_table :indices_users, :id => false do |t|
        t.column :index_id, :integer
        t.column :user_id, :integer
    end
    add_index :indices_users, [:user_id, :index_id]
    add_index :indices_users, :index_id
  end

  def self.down
    drop_table :indices
    drop_table :indices_users
  end
end
